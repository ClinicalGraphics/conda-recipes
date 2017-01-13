@echo off

rem initialize the per user DB for the current user...
"%PREFIX%\Library\miktex\texmfs\install\miktex\bin\initexmf.exe" --update-fndb --quiet
if errorlevel 1 exit 1

rem latex packages which are needed by nbconvert and probably other pdf producers
rem this is just a convenience install: miktex will install any missing package on the fly
rem don't check for errors so that this succeeds even if offline, etc...
"%PREFIX%\Library\miktex\texmfs\install\miktex\bin\mpm.exe" --update-db --quiet
for %%x in (
	acrotex
	adjustbox
	animate
	babel-dutch
	babel-english
	caption
	collectbox
	conv-xkv
	elsearticle
	enumitem
	eso-pic
	fancyhdr
	fontawesome
	ifoddpage
	insdljs
	l3kernel
	l3experimental
	l3packages
	lastpage
	kurier
	media9
	mptopdf
	ms
	natbib
	ocgx2
	pgf
	rotating
	symbol
	threeparttable
	url
	setspace
	wallpaper
	xcolor) do (
	"%PREFIX%\Library\miktex\texmfs\install\miktex\bin\mpm.exe" --quiet --install %%x
)
rem No final check as this should succeed even if the conda package is updated and the latex packages are already installed
