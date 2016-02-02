#!/bin/bash

if [ `uname` == Linux ]; then
    CC=gcc
    CXX=g++
    CMAKE=cmake
fi

include_path=${PREFIX}/include/python${PY_VER}
if [ ! -d $include_path ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  include_path=${PREFIX}/include/python${PY_VER}m
fi

PY_LIB="libpython${PY_VER}.so"
library_file_path=${PREFIX}/lib/${PY_LIB}
if [ ! -f $library_file_path ]; then
    library_file_path=${PREFIX}/lib/libpython3.5m.so
fi

# we're in gdcm-2.4.4 == $SRC_DIR
mkdir ../gdcm-build
cd ../gdcm-build

# deactivated OFFSCREEN and activated X instead
# also switching to the new programmable pipeline OpenGL2 renderer
$CMAKE \
    -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX" \
    -DCMAKE_INSTALL_RPATH:STRING="$PREFIX/lib" \
    -DGDCM_BUILD_SHARED_LIBS:BOOL=ON \
    -DGDCM_USE_VTK:BOOL=OFF \
    -DGDCM_USE_PVRG:BOOL=ON \
    -DGDCM_WRAP_PYTHON:BOOL=ON \
    -DSWIG_EXECUTABLE:FILEPATH=$PREFIX/bin/swig \
    -DPYTHON_EXECUTABLE:FILEPATH=$PYTHON \
    -DPYTHON_INCLUDE_PATH:PATH=$include_path \
    -DPYTHON_LIBRARY:FILEPATH=$library_file_path \
    -DGDCM_INSTALL_PYTHONMODULE_DIR:PATH=$PREFIX/lib/python${PY_VER}/site-packages/ \
    $SRC_DIR

# make the build use 8 concurrent processes
make -j${CPU_COUNT}
make install
