#!/bin/bash

./configure --prefix="$PREFIX"
make -j$CPU_COUNT
make install prefix="$PREFIX"libdir="$PREFIX"/lib64 exec_prefix="$PREFIX"