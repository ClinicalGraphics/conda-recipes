#!/usr/bin/env bash
BUILD_CONFIG=Release

mkdir build
cd build

if [ `uname` = 'Darwin' ]; then
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
fi

cmake .. -G "Ninja" \
    -DCMAKE_BUILD_TYPE=${BUILD_CONFIG} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_INSTALL_RPATH:PATH="${PREFIX}/lib" \
    -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
    -DU3D_SHARED:BOOL=ON \
    ${MACOSX_DEPLOYMENT_TARGET:+-D CMAKE_OSX_DEPLOYMENT_TARGET='10.9'}

ninja install
