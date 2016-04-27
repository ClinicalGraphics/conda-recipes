mkdir "%PREFIX%\miktex-portable\"
if errorlevel 1 exit 1

mkdir "%SCRIPTS%"
if errorlevel 1 exit 1

xcopy /e /i "%SRC_DIR%\*.*" "%PREFIX%\miktex-portable\"
if errorlevel 1 exit 1

for %%f in ("%PREFIX%\miktex-portable\miktex\bin\*.exe") do echo %%f %%* >> "%SCRIPTS%\%%~nf.bat"
if errorlevel 1 exit 1
