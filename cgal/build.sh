#!/bin/sh

mkdir build && cd build

# needs qt5 for imageio
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCGAL_INSTALL_LIB_DIR=lib \
  -DWITH_CGAL_ImageIO=OFF \
  -DWITH_CGAL_Qt5=OFF \
  -DWITH_examples=OFF \
  ..

make install -j${CPU_COUNT}
