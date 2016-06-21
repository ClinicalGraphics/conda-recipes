#!/bin/bash

mkdir -p $PREFIX/bin
mv $SRC_DIR/bin/* $PREFIX/bin/
chmod +x $PREFIX/bin/phantomjs