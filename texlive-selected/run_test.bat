:: Apparently, only the first test command from meta.yml is run
:: So here are all the test commands
call pdflatex --version
if errorlevel 1 exit 1
call pdftex --version
if errorlevel 1 exit 1
call pdflatex template.tex
if errorlevel 1 exit 1
