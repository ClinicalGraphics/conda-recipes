#!/bin/bash
mkdir -p $PREFIX/lib
/bin/cp /usr/lib64/libstdc++.so.6.0.13 $PREFIX/lib
/bin/ln -s libstdc++.so.6.0.13 $PREFIX/lib/libstdc++.so.6