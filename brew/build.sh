#!/bin/bash
find -type l -delete
cp -rf $SRC_DIR/* $PREFIX 2>/dev/null