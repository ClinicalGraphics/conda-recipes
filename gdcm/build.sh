#!/bin/bash

mkdir gdcm-build
#cd gdcm-build
#cmake ../GDCM-2.6.1

#export CC=$PREFIX/bin/gcc
#export CXX=$PREFIX/bin/g++

cmake \
    -G "Unix Makefiles"
    -DCMAKE_BUILD_TYPE=Release \
    -DGDCM_BUILD_APPLICATIONS:BOOL=ON \
    -DGDCM_BUILD_SHARED_LIBS:BOOL=ON \
    -DGDCM_WRAP_PYTHON:BOOL=ON \
    -DGDCM_USE_PVRG:BOOL=ON \
    -DPYTHON_LIBRARY="${PYTHON_LIBRARY}" \
    #-DPYTHON_LIBRARY:FILEPATH=$PREFIX/lib/libpython${PY_VER}.${SO_EXT} \
    -DPYTHON_INCLUDE_DIR="${PYTHON_INCLUDE_DIR}" \
    ..

make
make install
