#!/usr/bin/env bash

#ant -Dbasedir="$PREFIX"
#"$PREFIX"
#ant -f build.xml -Dbuildroot.dir="$PREFIX"/bin

#mkdir -vp ${PREFIX}/bin;

#ant -f build.xml -Dbuild.dir="$PREFIX"/bin
#ant
#cp -R $SRC_DIR/. "$PREFIX"
#touch .buckconfig

#cd "$PREFIX"
#./bin/buck
#cp -R $SRC_DIR/bin/. "$PREFIX"
#touch .buckconfig
#ant

#
#git clone https://github.com/facebook/buck.git
#cd buck
#ant
#./bin/buck --help
find -type l -delete
brew update
brew tap facebook/fb
brew install buck