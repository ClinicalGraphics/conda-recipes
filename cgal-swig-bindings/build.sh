#!/bin/sh

# There is an issue with python 3.6 and this test: https://github.com/CGAL/cgal-swig-bindings/issues/77
rm examples/python/test_polyline_simplification_2.py

mkdir build && cd build

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_JAVA=OFF \
  ..

make install -j${CPU_COUNT}
