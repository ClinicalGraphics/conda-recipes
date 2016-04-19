#!/bin/bash

mkdir build
cd build

if [ `uname` == Linux ]; then
    CC=${PREFIX}/bin/gcc
    CXX=${PREFIX}/bin/g++

    # FIXME refactor to reuse the python name (e.g. python3.5m)
    # FIXME detect any kind of suffix (m, or d)
    include_path=${PREFIX}/include/python${PY_VER}
    if [ ! -d $include_path ]; then
      # Control will enter here if $DIRECTORY doesn't exist.
      include_path=${PREFIX}/include/python${PY_VER}m
    fi

    PY_LIB="libpython${PY_VER}.so"
    library_file_path=${PREFIX}/lib/${PY_LIB}
    if [ ! -f $library_file_path ]; then
        library_file_path=${PREFIX}/lib/libpython${PY_VER}m.so
    fi

    cmake .. \
        -DCMAKE_C_COMPILER=$CC \
        -DCMAKE_CXX_COMPILER=$CXX \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DPYTHON_INCLUDE_PATH:PATH=$include_path \
        -DPYTHON_LIBRARY:FILEPATH=$library_file_path \
        -DPYTHON_INCLUDE_DIR="${PREFIX}/include" \
        -DPYTHONLIBS_VERSION_STRING="${PY_VER}"
        #\
#        -DBOOST_ROOT="${PREFIX}" \
#        -DBOOST_INCLUDEDIR="${PREFIX}/include" \
#        -DBOOST_LIBRARYDIR="${PREFIX}/lib" \
#        -DBoost_USE_STATIC_RUNTIME=0 \
#        -DBoost_USE_STATIC_LIBS=0
fi

make -j${CPU_COUNT}
make install
