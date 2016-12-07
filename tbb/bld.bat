rem  @echo off

@rem See https://github.com/wjakob/tbb
copy "%RECIPE_DIR%\CMakeLists.txt" .
if errorlevel 1 exit 1
mkdir build
cd build
copy "%RECIPE_DIR%\version_string.ver.in" .
if errorlevel 1 exit 1

cd ..

mkdir build_win
cd build_win

set CMAKE_CONFIG="Release"

cmake -LAH -G"NMake Makefiles"                               ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target INSTALL
if errorlevel 1 exit 1
