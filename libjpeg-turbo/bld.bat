cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX="%PREFIX%"

nmake install
