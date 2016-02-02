#!/bin/bash

mkdir build
cd build

include_path=${PREFIX}/include/python${PY_VER}
if [ ! -f ${PREFIX}/include/python${PY_VER} ]; then
    include_path=${PREFIX}/include/python${PY_VER}m
fi

library_path=${PREFIX}/lib/${PY_LIB}
if [ ! -f ${PREFIX}/include/python${PY_VER} ]; then
    library_path=${PREFIX}/lib/libpython3.5m.so
fi

if [ `uname` == Linux ]; then
    CC=gcc
    CXX=g++
    PY_LIB="libpython${PY_VER}.so"

    cmake .. \
        -DCMAKE_BUILD_TYPE=Release 
        -DGDCM_BUILD_APPLICATIONS:BOOL=ON 
        -DGDCM_BUILD_SHARED_LIBS:BOOL=ON 
        -DGDCM_WRAP_PYTHON:BOOL=ON 
        -DGDCM_USE_PVRG:BOOL=ON 
        -DPYTHON_LIBRARY=$library_path
        -DPYTHON_INCLUDE_DIR="${PREFIX}/include"
fi

make -j${CPU_COUNT}
make install
