#!/bin/bash

# use globs to take into account various possble suffixes: m, u, d
PYTHON_LIBRARY=`ls -d ${PREFIX}/lib/libpython* | head -n 1`
PYTHON_INCLUDE=`ls -d ${PREFIX}/include/python* | head -n 1`

if [ `uname` = "Linux" ]; then
    LINUX=true
elif [ `uname` = "Darwin" ]; then
    DARWIN=true
fi

mkdir ../gdcm-build
cd ../gdcm-build

# deactivated OFFSCREEN and activated X instead
# also switching to the new programmable pipeline OpenGL2 renderer
cmake \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
    -DCMAKE_BUILD_TYPE=Release \
    -DGDCM_BUILD_SHARED_LIBS:BOOL=ON \
    -DGDCM_USE_VTK:BOOL=OFF \
    -DGDCM_USE_PVRG:BOOL=ON \
    -DGDCM_WRAP_PYTHON:BOOL=ON \
    -DGDCM_WRAP_CSHARP=OFF \
    -DGDCM_WRAP_JAVA=OFF \
    -DGDCM_BUILD_TESTING:BOOL=OFF \
    -DGDCM_BUILD_EXAMPLES:BOOL=OFF \
    -DGDCM_BUILD_APPLICATIONS=OFF \
    -DGDCM_DOCUMENTATION:BOOL=OFF \
    -DGDCM_DOCUMENTATION_SKIP_MANPAGES:BOOL=ON \
    -DSWIG_EXECUTABLE:FILEPATH=${PREFIX}/bin/swig \
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON} \
    -DPYTHON_INCLUDE_PATH:PATH=${PYTHON_INCLUDE} \
    -DPYTHON_LIBRARY:FILEPATH=${PYTHON_LIBRARY} \
    -DGDCM_INSTALL_PYTHONMODULE_DIR:PATH=${SP_DIR} \
    ${DARWIN:+-DCMAKE_CXX_STANDARD=11} \
    ${SRC_DIR}

# make the build use 8 concurrent processes
make -j${CPU_COUNT}
make install
