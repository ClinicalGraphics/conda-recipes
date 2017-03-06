#! /bin/bash
# Copyright 2016 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.

set -e

configure_args=(
    --prefix="$PREFIX"
    --datarootdir="$PREFIX/share/texlive"
    --disable-all-pkgs
    --disable-native-texlive-build
    --enable-web2c
    --disable-ipc
    --disable-debug
    --disable-dependency-tracking
    --enable-silent-rules
    --with-banner-add=" Conda"
    # binaries:
    --disable-aleph
    --enable-tex
    --enable-etex
    --disable-eptex
    --disable-euptex
    --disable-luatex
    --disable-luajittex
    --disable-uptex
    --enable-pdftex
    --enable-xetex
    --enable-mf
    --disable-pmp
    --disable-upmp
    --enable-web-progs # includes bibtex
    # other packages:
    --enable-gsftopk
    --enable-texlive
    --enable-dvipdfm-x
    # support libraries:
    --x-includes=$PREFIX/include
    --x-libraries=$PREFIX/lib
    --without-system-harfbuzz # we've packaged this, but can't use it without native graphite2
    --with-system-icu
    --with-system-mpfr
    --with-mpfr-includes=$PREFIX/include
    --with-mprf-libdir=$PREFIX/lib
    --with-system-gmp
    --with-gmp-includes=$PREFIX/include
    --with-gmp-libdir=$PREFIX/lib
    --with-system-pixman
    --with-system-freetype2
    --without-system-graphite2
    --with-system-libpng
    --without-system-poppler
    --with-system-zlib
    --with-zlib-includes=$PREFIX/include
    --with-zlib-libdir=$PREFIX/lib
)

if [ -n "$OSX_ARCH" ] ; then
    export MACOSX_DEPLOYMENT_TARGET=10.9
    sysroot=/
    configure_args+=(
	--with-sysroot=$sysroot
    )
else
    configure_args+=(
        --with-system-cairo
    )
fi

export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig"

# kpathsea scans the texmf.cnf file to set up its hardcoded paths, so set them
# up before building. It doesn't seem to handle multivalued TEXMFCNF entries,
# so we patch that up after install.

mv texk/kpathsea/texmf.cnf tmp.cnf
sed \
    -e "s|TEXMFROOT =.*|TEXMFROOT = $PREFIX/share/texlive|" \
    -e "s|TEXMFLOCAL =.*|TEXMFLOCAL = $PREFIX/share/texlive/texmf-local|" \
    -e "/^TEXMFCNF/,/^}/d" \
    -e "s|%TEXMFCNF =.*|TEXMFCNF = $PREFIX/share/texlive/texmf-dist/web2c|" \
    <tmp.cnf >texk/kpathsea/texmf.cnf
rm -f tmp.cnf

mkdir conda
cd conda
../configure "${configure_args[@]}"
make -j4
make install

cd $PREFIX
ln -s pdftex bin/pdflatex # helpful; these look at argv[0]
ln -s xetex bin/xelatex

rm -f lib/*.a lib/*.la
rm -rf share/texlive/info
rm -rf share/man # clean this out so we can do the following mv:
mv share/texlive/man/ share/

mv share/texlive/texmf-dist/web2c/texmf.cnf tmp.cnf
sed \
    -e "s|TEXMFCNF =.*|TEXMFCNF = {$PREFIX/share/texlive/texmf-local/web2c, $PREFIX/share/texlive/texmf-dist/web2c}|" \
    <tmp.cnf >share/texlive/texmf-dist/web2c/texmf.cnf
rm -f tmp.cnf