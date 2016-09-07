#!/usr/bin/env bash

cmake -G "Unix Makefiles"
make
make install
initexmf --admin --configure
mpm --admin --update-db
initexmf --update-fndb

# Steps from: http://miktex.org/howto/build-unx
# Any args for CMAKE?
#cmake -G "Ninja" \
#	-Wno-dev \
#	-DWITH_UI_QT:BOOL=OFF \
#	-DUSE_SYSTEM_BOTAN:BOOL=OFF \
#	-DUSE_SYSTEM_GRAPHITE2:BOOL=OFF \
#	-DUSE_SYSTEM_HUNSPELL:BOOL=OFF \
#	-DUSE_SYSTEM_LOG4CXX:BOOL=OFF \
#	-DUSE_SYSTEM_MSPACK:BOOL=OFF \
#	-DUSE_SYSTEM_POPPLER:BOOL=OFF \
#	-DUSE_SYSTEM_POPPLER_QT5:BOOL=OFF \
#	-DUSE_SYSTEM_POPT:BOOL=OFF \
#	-DUSE_SYSTEM_POTRACE:BOOL=OFF \
#	-DUSE_SYSTEM_URIPARSER:BOOL=OFF \
#	-DUSE_SYSTEM_ZZIP:BOOL=OFF
#
#ninja install

# These steps are optional
# You use the MiKTeX configuration utility (initexmf) and the MiKTeX package manager (mpm) to configure "MiKTeX Tools" system-wide
# initexmf --admin --configure
# mpm --admin --update-db
# Once you have configured MiKTeX for the system, each user should create the per-user file name database
# initexmf --update-fndb