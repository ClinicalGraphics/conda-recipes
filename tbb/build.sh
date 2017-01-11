#!/bin/sh

make -j${CPU_COUNT}

install -d ${PREFIX}/lib
# filter libtbb.dylib ( or .so ), libtbbmalloc.dylib ( or .so )
cp `find . -name "*lib*" | grep tbb | grep release` ${PREFIX}/lib

install -d ${PREFIX}/include
# copy the include files
cp -r ./include/tbb ${PREFIX}/include

# simple test instead of "make test" to avoid timeout
${CXX} ${RECIPE_DIR}/tbb_example.c -I${PREFIX}/include -L${PREFIX}/lib -ltbb -o tbb_example
DYLD_LIBRARY_PATH=${PREFIX}/lib ./tbb_example
