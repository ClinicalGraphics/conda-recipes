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
    ${MACOSX_DEPLOYMENT_TARGET:+-DCMAKE_OSX_DEPLOYMENT_TARGET='10.9'} \
    -DU3D_SHARED:BOOL=ON

ninja install
