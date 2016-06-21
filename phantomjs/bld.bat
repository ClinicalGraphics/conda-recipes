mkdir "%PREFIX%\Scripts"
copy "%SRC_DIR%\bin\phantomjs.exe" "%PREFIX%\Scripts\phantomjs.exe"
if errorlevel 1 exit 1
