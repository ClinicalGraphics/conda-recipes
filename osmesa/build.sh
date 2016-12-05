#!/bin/bash

./configure                                         \
  --prefix=$PREFIX                                  \
  --enable-opengl                                   \
  --disable-gles1                                   \
  --disable-gles2                                   \
  --disable-va --disable-xvmc --disable-vdpau       \
  --enable-shared-glapi                             \
  --disable-texture-float                           \
  --enable-gallium-llvm --disable-llvm-shared-libs  \
  --with-gallium-drivers=swrast,swr                 \
  --disable-dri --with-dri-drivers=                 \
  --disable-egl --with-egl-platforms= --disable-gbm \
  --disable-glx                                     \
  --disable-osmesa --enable-gallium-osmesa

make -j8
make install