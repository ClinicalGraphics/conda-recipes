# Copyright 2014-2016 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.

# This script builds a mega-tarball of TeX packages. This is necessary because
# Conda doesn't let us define a package with multiple source tarballs, and I
# don't want to ship a separate package for all of these stupid dependencies.
#
# If a certain file (say "expl3.sty") is needed, there are several ways to figure out
# which TexLive package might contain it.
#
# 1. Query on rpmfind.net:
#
#   https://www.rpmfind.net/linux/rpm2html/search.php?query=tex%28expl3.sty%29
#
# (the percent escaped characters are parentheses) However, this falls down
# with recent changes made in TexLive.
#
# 2. Create a local install of TeXLive, and use its tool. After installation, run something
# like:
#
#   $ tlmgr search --global --file expl3.sty
#
# This is definitely the best option since it stays up-to-date.
#
# 3. In the nuclear option, you can navigate the official SVN tree of
# everything here:
#
#   https://www.tug.org/svn/texlive/trunk/Master/
#
# If you can find the needed file in there, the commit messages sometimes
# indicate which tarballed package it goes into. The partitioning of files
# into TeXLive packages is defined in the configuration files here:
#
#   https://www.tug.org/svn/texlive/trunk/Master/tlpkg/tlpsrc/
#
# These also have the files such as "collections-basic.tlpsrc" that define the
# fundamental set of packages for a TeXLive distribution.
#! /bin/bash

if [ -z "$1" ] ; then
    echo >&2 "usage: $0 <version>

Where the recommended version is of the form YYYYMMDD, e.g., 20160121"
    exit 1
fi

tarbase="texlive-packages-$1"
urlbase="http://mirrors.ctan.org/systems/texlive/tlnet/archive"

work="$(mktemp -d)"
origpwd="$(pwd)"
cd "$work"
mkdir -p src unpacked/texmf-dist
cd src

while read pkg options ; do
    echo $pkg
    wget $urlbase/$pkg.tar.xz
    dir=../unpacked/texmf-dist
    src=../../src
    filter="*"

    for option in $(echo $options |sed -e 's/,/ /g') ; do
	case $option in
	    updir)
            dir=../unpacked
            src=../src
        ;;
	    kpathsea)
            # This package includes some .tcx files that are wanted by
            # fmtutil, but also includes various web2c/ configuration
            # files that are provided by our texlive-core-core package, and the
            # versions in the tarball are Not What We Want. So with this
            # quasi-hack we extract only the desired files.
            filter='*.tcx'
        ;;
	    none)
	    ;;
	    *)
	        echo unhandled option $option ; exit 1
	    ;;
	esac
    done
    (cd $dir && tar xJf $src/$pkg.tar.xz --wildcards "$filter")
done <<EOF
adjustbox none
ae none
amscls none
amsfonts none
amsmath none
avantgar none
babel none
babel-english none
babel-dutch none
bibtex updir
booktabs none
caption none
cm none
collectbox none
courier none
dblfloatfix none
dehyph-exptl none
dvipdfmx updir
dvips updir
ec none
elsarticle none
emulateapj none
enctex none
enumitem none
epsf none
eso-pic none
etex none
etex-pkg none
etoolbox none
euenc none
eurosym none
fancyhdr none
fancytooltips none
fancyvrb none
filehook none
fontspec none
geometry none
glyphlist none
graphics none
graphics-cfg none
graphics-def none
gsftopk none
hyperref none
hyph-utf8 none
hyphen-dutch none
hyphen-english none
ifluatex none
ifoddpage none
ifxetex none
knuth-lib none
knuth-local none
kpathsea updir,kpathsea
kurier none
l3kernel none
l3packages none
l3experimental none
lastpage none
latex none
latex-fonts none
latexconfig none
lineno none
makeindex updir
media9 none
metafont updir
mflogo none
mfware updir
microtype none
mptopdf none
ms none
multirow none
natbib none
oberdiek none
ocgx2 none
pdftex updir
pgf none
plain none
psnfss none
revtex none
revtex4 none
ruhyphen none
setspace none
symbol none
tds none
threeparttable none
tetex updir
tex-ini-files none
texlive.infra updir
textcase none
times none
titlesec none
tools none
ucharcat none
ucs none
ukrhyph none
ulem none
unicode-data none
unicode-math none
updmap-map none
url none
wallpaper none
xcolor none
xetex updir
xkeyval none
xunicode none
zapfding none
EOF

cd ../unpacked

# unpack other required packages not found on repo
echo "unpacking other required packages"
tar xJf "$origpwd"/acrotex.tar.xz -C texmf-dist/
tar xJf "$origpwd"/rotating.tar.xz -C texmf-dist/

rm -rf readme-html.dir readme-txt.dir
rm -f index.html README README.usergroups
tar cjf ../"$tarbase".tar.bz2 *

cd "$origpwd"
mv "$work/$tarbase".tar.bz2 .
sha256sum "$tarbase".tar.bz2
rm -rf "$work"
