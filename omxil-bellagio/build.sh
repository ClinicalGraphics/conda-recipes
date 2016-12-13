#!/bin/sh

autoreconf -i
./configure --prefix="$PREFIX"
make
make install -j8
make check
