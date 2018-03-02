#!/usr/bin/env bash
cd ffi

# build the raytracer_ffi library
cargo build --release

# copy file from target/release to prefix/lib
cp ./target/release/libraytracer_ffi.so ${PREFIX}/lib/libraytracer_ffi.so

# install the python library
#cd ..
#python setup.py install --home=~