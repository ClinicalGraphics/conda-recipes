#!/bin/bash

mkdir -vp ${PREFIX}/bin;

cp -v geckodriver ${PREFIX}/bin/ || exit 1;
chmod -v 755 ${PREFIX}/bin/geckodriver || exit 1;
