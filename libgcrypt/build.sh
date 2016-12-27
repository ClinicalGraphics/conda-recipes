#!/bin/bash

./configure --prefix=$PREFIX --with-gpg-error-config=$PREFIX && make && make check && make install