
:: Add more build steps here, if they are necessary.

:: See
:: http://docs.continuum.io/conda/build.html
:: for a list of environment variables that are set during the build process.

:: @echo off

set BUILD_CONFIG=Release

REM pick generator based on python version
if %PY_VER%==2.7 (
    set GENERATOR_NAME=Visual Studio 9 2008
)
if %PY_VER%==3.4 (
    set GENERATOR_NAME=Visual Studio 10 2010
)
if %PY_VER%==3.5 (
    set GENERATOR_NAME=Visual Studio 14 2015
)

REM pick architecture
if %ARCH%==64 (
	set GENERATOR_NAME=%GENERATOR_NAME% Win64
)

REM tell cmake where Python is
set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

REM move folder
mkdir build
cd build


REM generate visual studio solution
cmake %SRC_DIR% -G"%GENERATOR_NAME%" ^
    -Wno-dev ^
    -DCMAKE_BUILD_TYPE=%BUILD_CONFIG% ^
	-DCMAKE_C_COMPILER=%CC% ^
	-DCMAKE_CXX_COMPILER=%CXX% ^
	-DCMAKE_BUILD_TYPE=Release ^
	-DCMAKE_INSTALL_PREFIX=%PREFIX% ^
	-DPYTHON_INCLUDE_DIR=%PREFIX%\include\python%PY_VER% ^
	-DPYTHONLIBS_VERSION_STRING=%PY_VER% ^
    -DBOOST_ROOT=%PREFIX%

if errorlevel 1 exit 1


REM move folder

if errorlevel 1 exit 1

cd ..

make .
make install
exit /b 0
