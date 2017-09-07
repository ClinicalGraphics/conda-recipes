#!/bin/bash

# Download and unpack Acrotex package
mkdir -p $PREFIX/texmf-local/tex/latex/local
cd $PREFIX/texmf-local/tex/latex/local
wget http://mirrors.ctan.org/macros/latex/contrib/acrotex.zip
unzip acrotex.zip
rm acrotex.zip

# Install the Acrotex package
cd acrotex
texhash
latex acrotex.ins

# Install some needed texlive packages with tlmgr
tlmgr install symbol conv-xkv media9 ocgx2 enumitem kurier adjustbox collectbox wallpaper lastpage multirow fontawesome threeparttable animate
