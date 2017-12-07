:: Update tlmgr because it might be outdated
mkdir %LIBRARY_PREFIX%/tlpkg/backups
call tlmgr update --self

if errorlevel 1 exit 1

:: Download and unpack Acrotex package
mkdir %LIBRARY_PREFIX%\texmf-local\tex\latex\local
cd %LIBRARY_PREFIX%\texmf-local\tex\latex\local
python -c "import urllib.request; urllib.request.urlretrieve('http://mirrors.ctan.org/macros/latex/contrib/acrotex.zip', 'acrotex.zip')"
python -c "import zipfile; zipfile.ZipFile('acrotex.zip').extractall()"
del acrotex.zip

:: Install the Acrotex package
cd acrotex
texhash
latex acrotex.ins

if errorlevel 1 exit 1

:: Install some needed texlive packages with tlmgr
tlmgr install symbol conv-xkv media9 ocgx2 enumitem kurier adjustbox collectbox wallpaper lastpage multirow fontawesome threeparttable animate titling

if errorlevel 1 exit 1
