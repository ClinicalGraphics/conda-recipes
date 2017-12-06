:: Update tlmgr because it might be outdated
tlmgr update --self

:: Download and unpack Acrotex package
mkdir -p %LIBRARY_PREFIX%/texmf-local/tex/latex/local
cd %LIBRARY_PREFIX%/texmf-local/tex/latex/local
python -c "import urllib; urllib.urlretrieve('http://mirrors.ctan.org/macros/latex/contrib/acrotex.zip', 'acrotex.zip')"
python -c "import zipfile; zipfile.ZipFile('acrotex.zip').extractall()"
rm acrotex.zip

:: Install the Acrotex package
cd acrotex
texhash
latex acrotex.ins

:: Install some needed texlive packages with tlmgr
tlmgr install symbol conv-xkv media9 ocgx2 enumitem kurier adjustbox collectbox wallpaper lastpage multirow fontawesome threeparttable animate titling
