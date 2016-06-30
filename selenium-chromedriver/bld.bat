REM SET install_dir=C:\Program Files (x86)\selenium\chromedriver

REM MKDIR "%install_dir%"

for /R "%SRC_DIR%" %%f in (*.exe) do copy %%f "%PYTHONPATH%/Scripts"
if errorlevel 1 exit 1

REM ECHO "Adding chromedriver install directory to the persistent path:" %install_dir%
REM setx /M PATH "%install_dir%;%PATH%"
REM if errorlevel 1 exit 1