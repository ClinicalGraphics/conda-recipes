:: There is an issue with python 3.6 and this test: https://github.com/CGAL/cgal-swig-bindings/issues/77
del examples\python\test_polyline_simplification_2.py

mkdir build && cd build

cmake -LAH -G"NMake Makefiles"                ^
  -DCMAKE_BUILD_TYPE="Release"         ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"      ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"   ^
  -DPYTHON_MODULE_PATH="%SP_DIR%"             ^
  -DBUILD_JAVA=OFF                            ^
  ..

cmake --build . --config %CMAKE_CONFIG% --target INSTALL