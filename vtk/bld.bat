@echo off

mkdir build
cd build

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
set ARCH_NAME=x86
if %ARCH%==64 (
	set GENERATOR_NAME=%GENERATOR_NAME% Win64
	set ARCH_NAME=x86_64
)

REM tell cmake where Python is
set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

cmake .. -G"%GENERATOR_NAME%" ^
    -Wno-dev ^ 
    -DCMAKE_BUILD_TYPE=%BUILD_CONFIG% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_RPATH:STRING=%LIBRARY_LIB% ^
    -DCMAKE_INSTALL_NAME_DIR=%LIBRARY_LIB% ^
    -DBUILD_DOCUMENTATION=OFF ^
    -DVTK_HAS_FEENABLEEXCEPT=OFF ^
    -DBUILD_TESTING=ON ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_SHARED_LIBS=ON ^    
    -DVTK_RENDERING_BACKEND:STRING=OpenGL2 ^
    -DVTK_USE_SYSTEM_LIBRARIES:BOOL=OFF ^
    -DVTK_USE_LARGE_DATA:BOOL=ON ^
    -DVTK_LEGACY_REMOVE:BOOL=ON ^
    -DVTK_DEBUG_LEAKS:BOOL=ON ^
    -DVTK_ENABLE_KITS:BOOL=OFF
    -DVTK_WRAP_TCL:BOOL=OFF ^
    -DVTK_WRAP_JAVA:BOOL=OFF ^
    -DVTK_LINKER_FATAL_WARNINGS:BOOL=ON ^    
    -DModule_vtkPythonInterpreter:BOOL=ON ^     
    -DVTK_WRAP_PYTHON=ON ^
    -DVTK_PYTHON_VERSION=%VTK_PYTHON_VERSION% ^
    -DPYTHON_EXECUTABLE:FILEPATH=%PYTHON% ^
    -DPYTHON_INCLUDE_PATH=%PREFIX%\\include ^
    -DPYTHON_INCLUDE_DIR:PATH=%PREFIX%\\include ^
    -DPYTHON_LIBRARY:FILEPATH=%PYTHON_LIBRARY% ^
    -DVTK_INSTALL_PYTHON_MODULE_DIR=%PREFIX%\\Lib\\site-packages

cmake --build . --target INSTALL --config %BUILD_CONFIG%
if errorlevel 1 exit 1

exit /b 0