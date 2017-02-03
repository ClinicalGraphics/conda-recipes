mkdir build
cd build

set BUILD_CONFIG=Release

:: tell cmake where Python is
set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

SET TBB_ROOT=%PREFIX%\bin\

cmake .. -G "Ninja" ^
    -Wno-dev ^
    -DCMAKE_BUILD_TYPE=%BUILD_CONFIG% ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DBUILD_DOCUMENTATION:BOOL=OFF ^
    -DBUILD_TESTING:BOOL=OFF ^
    -DBUILD_EXAMPLES:BOOL=OFF ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%" ^
    -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
    -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
    -DVTK_ENABLE_VTKPYTHON:BOOL=OFF ^
    -DVTK_WRAP_PYTHON:BOOL=ON ^
    -DVTK_PYTHON_VERSION:STRING="%PY_VER%" ^
    -DVTK_INSTALL_PYTHON_MODULE_DIR:PATH="%SP_DIR%" ^
    -DVTK_HAS_FEENABLEEXCEPT:BOOL=OFF ^
    -DVTK_RENDERING_BACKEND=OpenGL2 ^
    -DModule_vtkRenderingMatplotlib=ON ^
    -DVTK_USE_SYSTEM_ZLIB:BOOL=ON ^
    -DVTK_USE_SYSTEM_FREETYPE:BOOL=ON ^
    -DVTK_USE_SYSTEM_LIBXML2:BOOL=ON ^
    -DVTK_USE_SYSTEM_PNG:BOOL=ON ^
    -DVTK_USE_SYSTEM_JPEG:BOOL=ON ^
    -DVTK_USE_SYSTEM_TIFF:BOOL=ON ^
    -DVTK_USE_SYSTEM_EXPAT:BOOL=ON
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
