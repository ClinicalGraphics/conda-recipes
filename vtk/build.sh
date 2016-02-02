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
        -DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
        -DBUILD_DOCUMENTATION=OFF \
        -DVTK_HAS_FEENABLEEXCEPT=OFF \
        -DBUILD_TESTING=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_SHARED_LIBS=ON \
        -DVTK_WRAP_PYTHON=ON \
        -DPYTHON_EXECUTABLE=${PYTHON} \
        -DPYTHON_INCLUDE_PATH=$include_path \
        -DPYTHON_LIBRARY=$library_path \
        -DVTK_INSTALL_PYTHON_MODULE_DIR=${SP_DIR} \
        -DVTK_USE_X=ON \
        -DModule_vtkRenderingMatplotlib=ON 

fi

make -j${CPU_COUNT}
make install
