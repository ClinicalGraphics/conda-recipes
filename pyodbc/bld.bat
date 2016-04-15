REM pick build configuration
set BUILD_CONFIG=Release

REM pick generator based on python version
if %PY_VER%==2.6 (
    set GENERATOR_NAME=Visual Studio 9 2008
)
if %PY_VER%==2.7 (
    set GENERATOR_NAME=Visual Studio 9 2008
)
if %PY_VER%==3.3 (
    set GENERATOR_NAME=Visual Studio 10 2010
)
if %PY_VER%==3.4 (
    set GENERATOR_NAME=Visual Studio 10 2010
)
if %PY_VER%==3.5 (
    set GENERATOR_NAME=Visual Studio 14 2015
)

REM pick architecture
set ARCH_NAME=x86
if %ARCH%==64 (
	set GENERATOR_NAME=%GENERATOR_NAME% Win64
	set ARCH_NAME=amd64
)

REM tell cmake where Python is
set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib
set PYTHON_INCLUDE_DIR=%PREFIX%\include

REM copy build output into package
set PYODBCDIR=%SP_DIR%\pyodbc

python setup.py build
if errorlevel 1 exit 1

mkdir "%PYODBCDIR%"
if errorlevel 1 exit 1

xcopy .\build\lib.win-%ARCH_NAME%-%PY_VER%\* "%PYODBCDIR%"
if errorlevel 1 exit 1

REM link executables from Scripts dir so that they will be on the PATH
for %%f in ("%PYODBCDIR%\*.exe") do echo %%f %%* >> "%SCRIPTS%\%%~nf.bat"
if errorlevel 1 exit 1

REM link python wrappers so that they will be importable
echo %PYODBCDIR% >> "%SP_DIR%\pyodbc.pth"
if errorlevel 1 exit 1

exit /b 0
