#!/usr/bin/env bash

export JAVA_HOME=$PREFIX/jdk
export ANT_HOME=$PREFIX/bin

ant --execdebug

#ant package

#ant compile
#
#TGT=${PREFIX}/share/${PKG_NAME}-${PKG_VERSION}-${PKG_BUILDNUM}
#mkdir -p ${TGT}
#mkdir -p ${PREFIX}/bin
#
#./build.sh -Ddist.dir=$PREFIX dist
#./build.sh install-lite
#
##cp -R dist/bin ${TGT}
##cp -R dist/lib ${TGT}
##for file in `ls -1 ${TGT}/bin`
##	do ln -s ${TGT}/bin/$file ${PREFIX}/bin/$file
##done

mkdir -p ${PREFIX}/bin

#./build.sh -Ddist.dir=$PREFIX dist
#./build.sh install-lite

#cp -R dist/bin ${TGT}
#cp -R dist/lib ${TGT}
#for file in `ls -1 ${TGT}/bin`
#	do ln -s ${TGT}/bin/$file ${PREFIX}/bin/$file
#done