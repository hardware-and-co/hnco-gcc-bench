#!/bin/bash
if [ "$1" == "" ]; then
	NB_THREADS=$((`lscpu | grep "CPU(s):" | sed -r s/.*\([0-9]+\).*/\\\1/g` + 1))
else
	NB_THREADS=$1
fi
svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_8_2_0_release gcc
cd gcc
mkdir build
cd build
rm -rf *
../configure --target=x86_64-linux-gnu --disable-multilib
make clean
time make -j$NB_THREADS
