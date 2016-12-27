#!/usr/bin/env bash
BUILD_CONFIG=Release

mkdir build
cd build

cmake .. -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=$BUILD_CONFIG \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DU3D_SHARED:BOOL=ON

make install
