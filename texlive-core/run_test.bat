:: Apparently, only the first test command from meta.yml is run
:: So here are all the test commands
pdftex --version
if errorlevel 1 exit 1
bibtex --version
if errorlevel 1 exit 1
call tlmgr --version
if errorlevel 1 exit 1
pdflatex --version
if errorlevel 1 exit 1
pdflatex template.tex
if errorlevel 1 exit 1
