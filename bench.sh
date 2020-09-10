#!/bin/bash
set -e
DIR=`dirname $0`
if [ "$1" == "" ]; then
	NB_THREADS=$((`lscpu | grep "^CPU(s):" | sed -E "s/.* ([0-9]+)/\1/g"`))
else
	NB_THREADS=$1
fi
cd $DIR
if [ ! -d gcc ]; then
	git clone --branch releases/gcc-9.3.0 --depth 1 git://gcc.gnu.org/git/gcc.git
fi
cd gcc
if [ ! -d build ]; then
  mkdir build
fi
cd build
rm -rf *
../configure --target=x86_64-linux-gnu --disable-multilib
make clean
time make -j$NB_THREADS
