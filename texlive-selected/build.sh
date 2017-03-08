# Copyright 2016 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.
#! /bin/bash

[ "$NJOBS" = '<UNDEFINED>' -o -z "$NJOBS" ] && NJOBS=1
set -e -x

dist=$PREFIX/share/texlive/
mkdir -p $dist
cp -a . $dist

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

temp=$(mktemp)
for fmt in tex latex etex pdftex pdflatex; do
    $PREFIX/bin/fmtutil-sys --byfmt $fmt >$temp 2>&1
    rc=$?
    if [ $rc -ne 0 ] ; then
	# Definite error.
	cat $temp >&2
	rm -f $temp
	exit 1
    fi
done

# Just in case, dump things that look like warnings and errors,
# specifically ignoring a few that we know we don't care about. We could
# potentially signal failure if we see an ERROR in the log with a zero
# exitcode, but that seems too fragile.
#
# Examples of types of messages we're choosing to ignore:
#
#   fmtutil [WARNING]: inifile eptex.ini for eptex/eptex not found.
#   fmtutil [ERROR]: not building luajittex due to missing engine luajittex.
# grep -iE '(warning|error)' $temp |grep -v 'inifile.*not found' |grep -v 'missing engine' >&2

# Likewise, update the font mapping files. Very similar situation as above. Here we need
# to munge the config file but that's not too tricky. (Famous last words.)

tab="	" # <- embedded tab character
pfx="$PREFIX/share/texlive/texmf-dist/web2c"
cp $pfx/updmap-hdr.cfg $pfx/updmap.cfg
$PREFIX/bin/updmap-sys --listavailablemaps 2>/dev/null |grep "Map$tab" |awk '{print $1 " " $2}' >>$pfx/updmap.cfg
$PREFIX/bin/updmap-sys >$temp 2>&1
rc=$?
if [ $rc -ne 0 ] ; then
    # Definite error
    cat $temp >&2
    rm -f $temp
    exit 1
fi

# Add kurier font to updmap.cfg and run updmap again -- this needs to be done for codeship ci.
echo "Map kurier.Map" >>$pfx/updmap.cfg
yes | $PREFIX/bin/updmap-sys --syncwithtrees
$PREFIX/bin/updmap-sys --enable Map=kurier.map
$PREFIX/bin/updmap

# Remove paranoid mode from texmf.cnf
sed -i -e 's/openout_any = a/openout_any = b/g' "$PREFIX/share/texlive/texmf-dist/web2c/texmf.cnf"

# Install files from insdljs.ins
cd "$PREFIX/share/texlive/texmf-dist/tex/latex/acrotex/"
pdflatex insdljs.ins
#$PREFIX/bin/pdftex "$PREFIX/share/texlive/texmf-dist/tex/latex/acrotex/insdljs.ins"
#$PREFIX/bin/pdflatex "$PREFIX/share/texlive/texmf-dist/tex/latex/acrotex/insdljs.ins"

# All done.

rm -f $temp
exit 0