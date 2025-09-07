#!/bin/bash
set -e
SELF=`readlink -f $0`
DIR=`dirname $SELF`
if [ "$1" == "" ]; then
    NB_THREADS=$((`nproc`))
else
    NB_THREADS=$1
fi
cd $DIR
if [ ! -d gcc ]; then
    git clone --branch releases/gcc-11.2.0 --depth 1 git://gcc.gnu.org/git/gcc.git
fi
cd -
cd $DIR/gcc
if [ ! -d build ]; then
    mkdir build
else
    rm -rf build
    mkdir build
fi
cd -
cd $DIR/gcc/build
../configure --target=x86_64-linux-gnu --disable-multilib
make clean
/bin/time -p make -j$NB_THREADS
cd -
