# Copyright 2016 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.

#! /bin/bash

[ "$NJOBS" = '<UNDEFINED>' -o -z "$NJOBS" ] && NJOBS=1
set -e -x

dist=$PREFIX/share/texlive/
mkdir -p $dist
cp -a . $dist

# make the tarball and extract
#cp "$RECIPE_DIR"/make-tarball.sh $dist/texmf-dist/scripts/texlive/
#sh $dist/texmf-dist/scripts/texlive/make-tarball.sh now
#tar xvjf $dist/texmf-dist/scripts/texlive/texlive-packages-now.tar.bz2 -C $dist/

# One annoying script not distributed in any useful source tarball.
cp "$RECIPE_DIR"/mktexlsr.pl $dist/texmf-dist/scripts/texlive/
chmod +x $dist/texmf-dist/scripts/texlive/mktexlsr.pl

# We create these files here, but we also need to rerun fmtutil in a post-link
# script since some of the .fmt files embed absolute paths in a way that can't
# be safely patched up with Conda's standard methods.
cd $dist
mktexlsr

# Tell fontconfig about our fonts
mkdir -p $PREFIX/etc/fonts/conf.d
conffile=$PREFIX/etc/fonts/conf.d/15-texlive-fonts.conf
cat <<'EOF' >$conffile
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<!-- Font directories provided by the Anaconda TeXLive package -->
EOF
find $dist/texmf-dist -name '*.otf' |xargs -n1 dirname |sort |uniq \
    |awk '{print "<dir>" $1 "</dir>"}' >>$conffile
echo '</fontconfig>'>>$conffile
