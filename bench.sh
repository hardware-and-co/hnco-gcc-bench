#!/bin/bash
if [ "$1" == "" ]; then
	NB_THREADS=$((1+`lscpu | grep "^CPU(s):" | sed -E "s/.*([0-9]+).*/\1/g"`))
else
	NB_THREADS=$1
fi
if [ ! -d gcc ]; then
	svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_8_2_0_release gcc
fi
cd gcc
mkdir build 2>&1 >/dev/null
cd build
rm -rf *
../configure --target=x86_64-linux-gnu --disable-multilib
make clean
time make -j$NB_THREADS
