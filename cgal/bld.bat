mkdir build && cd build

cmake -LAH -G"NMake Makefiles"                ^
  -DCMAKE_BUILD_TYPE="Release"         ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"      ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"   ^
  -DWITH_CGAL_ImageIO=OFF -DWITH_CGAL_Qt5=OFF ^
  ..

cmake --build . --config %CMAKE_CONFIG% --target INSTALL
