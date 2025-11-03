#!/usr/bin/env bash
#author: rangapv@yahoo.com
#03-11-25

cuda_python(){

lnxdr=`uname -v | awk '{split($0,a," "); print a[1]}'`

pypip="pip3"
#install
cupy1=`${pypip} install cuda-python`
cupy1s="$?"
echo "cuda-python installed `{pypip} show cuda-python`"
}

cuda_python
