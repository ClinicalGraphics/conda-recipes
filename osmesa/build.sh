#!/bin/bash

autoreconf -fi

./configure                                         \
  --prefix="$PREFIX"                                \
  --enable-opengl                                   \
  --enable-shared                                   \
  --disable-gles1                                   \
  --disable-gles2                                   \
  --disable-shared-glapi                            \
  --disable-glx                                     \
  --disable-va --disable-xvmc --disable-vdpau       \
  --enable-texture-float                            \
  --enable-gallium-llvm --enable-llvm-shared-libs   \
  --with-gallium-drivers=swrast                     \
  --disable-dri --with-dri-drivers=                 \
  --disable-egl --with-egl-platforms= --disable-gbm \
  --disable-osmesa --enable-gallium-osmesa

make -j8
make -j4 install