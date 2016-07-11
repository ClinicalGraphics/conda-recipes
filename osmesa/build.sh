#!/bin/bash

if [ "$(uname -s)" == "Darwin" ]; then
	# LLVMdev contains std::move calls which are not supported by the 10.6/10.7
	# libc++. So use 10.9
	export MACOSX_DEPLOYMENT_TARGET=10.9
fi

autoreconf -fi

./configure                                             \
	CXXFLAGS="-O2 -g -DDEFAULT_SOFTWARE_DEPTH_BITS=31"  \
	CFLAGS="-O2 -g -DDEFAULT_SOFTWARE_DEPTH_BITS=31"    \
	--enable-texture-float                              \
	--disable-xvmc                                      \
	--disable-glx                                       \
	--disable-dri                                       \
	--with-dri-drivers=""                               \
	--with-gallium-drivers="swrast"                     \
	--disable-shared-glapi                              \
	--disable-egl                                       \
	--with-egl-platforms=""                             \
	--enable-gallium-osmesa                             \
	--enable-gallium-llvm=yes                           \
	--disable-gles1                                     \
	--disable-gles2                                     \
    --prefix=$PREFIX

make -j2
make -j4 install