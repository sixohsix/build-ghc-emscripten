#!/bin/sh

ROOT_DIR="$PWD"
PATH=$PATH:$ROOT_DIR/bin
CONFIGURE="./configure --prefix=$ROOT_DIR"
MAKE="make -j4"
INSTALL="make install"


# Install deps
sudo apt-get -y build-dep ghc6 llvm
sudo apt-get -y wget svn scons

# Get code
mkdir -p $ROOT_DIR/build $ROOT_DIR/bin

cd $ROOT_DIR/build
wget -c http://www.haskell.org/ghc/dist/7.2.1/ghc-7.2.1-src.tar.bz2
wget -c https://github.com/kripken/emscripten/tarball/master -O emscripten-master.tgz
wget -c http://llvm.org/releases/2.9/llvm-2.9.tgz
svn export http://v8.googlecode.com/svn/trunk/ v8

tar -xzf llvm-2.9.tgz
tar -xjf ghc-7.2.1-src.tar.bz2
tar -xzf emscripten-master.tgz

cd $ROOT_DIR/build/llvm-2.9
$CONFIGURE
$MAKE
$INSTALL

cd $ROOT_DIR/build/ghc-7.2.1
$CONFIGURE
$MAKE
$INSTALL

cd $ROOT_DIR/build/v8
scons d8
cp d8 $ROOT_DIR/bin/

echo "All done."
