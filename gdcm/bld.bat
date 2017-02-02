mkdir build
cd build

::Remove dll files if they exists since they need to be copied
if exist "%LIBRARY_BIN%\vccorlib140.dll" (
  del /f "%LIBRARY_BIN%\vccorlib140.dll"
)
if exist "%LIBRARY_BIN%\vcomp140.dll" (
  del /f "%LIBRARY_BIN%\vcomp140.dll"
)
if exist "%LIBRARY_BIN%\msvcp140.dll" (
  del /f "%LIBRARY_BIN%\msvcp140.dll"
)
if exist "%LIBRARY_BIN%\concrt140.dll" (
  del /f "%LIBRARY_BIN%\concrt140.dll"
)
if exist "%LIBRARY_BIN%\vcruntime140.dll" (
  del /f "%LIBRARY_BIN%\vcruntime140.dll"
)

set BUILD_CONFIG=Release

set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

cmake .. -G "Ninja" ^
    -Wno-dev ^
    -DCMAKE_BUILD_TYPE=%BUILD_CONFIG% ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_RPATH:STRING="%LIBRARY_LIB%" ^
    -DGDCM_BUILD_SHARED_LIBS:BOOL=ON ^
    -DGDCM_BUILD_APPLICATIONS:BOOL=ON ^
    -DGDCM_BUILD_TESTING:BOOL=OFF ^
    -DGDCM_BUILD_EXAMPLES:BOOL=OFF ^
    -DGDCM_BUILD_APPLICATIONS=OFF ^
    -DGDCM_USE_VTK:BOOL=OFF ^
    -DGDCM_WRAP_PYTHON:BOOL=ON ^
    -DGDCM_DOCUMENTATION:BOOL=OFF ^
    -DSWIG_EXECUTABLE:FILEPATH="%LIBRARY_BIN%\swig" ^
    -DPYTHON_EXECUTABLE="%PYTHON%" ^
    -DPYTHON_INCLUDE_DIR="%PREFIX%\include" ^
    -DPYTHON_LIBRARY="%PYTHON_LIBRARY%" ^
    -DGDCM_INSTALL_PYTHONMODULE_DIR:PATH="%SP_DIR%" ^
    -DGDCM_INSTALL_NO_DOCUMENTATION:BOOL=ON ^
    -DGDCM_INSTALL_NO_DEVELOPMENT:BOOL=ON ^
    -DGDCM_INSTALL_BIN_DIR="%LIBRARY_BIN%" ^
    -DGDCM_INSTALL_LIB_DIR="%LIBRARY_LIB%" ^
    -DGDCM_INSTALL_DATA_DIR="%LIBRARY_PREFIX%" ^
    -DGDCM_INSTALL_INCLUDE_DIR="%LIBRARY_INC%"
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
