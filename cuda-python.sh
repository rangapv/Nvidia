#!/usr/bin/env bash
#author: rangapv@yahoo.com
#03-11-25

cuda_python(){

cupyv="12.9.4"

echo "The verison of cuda-python to be installed is ${cupyv}, if you need a different version press y"
read cupnv

if [[ ( ${cupnv} == "y" ) ]]
then
	echo "enter the new version of cuda-python that needs to be installed"
	read cupnv1
	cupyv="${cupnv1}"
fi
echo "Going to install cuda-python version ${cupyv}"

lnxdr=`uname -v | awk '{split($0,a," "); print a[1]}'`
pypip="pip3"
#install
#cupy1=`${pypip} install cuda-python`
cupy1=`${pypip} install -U cuda-python==${cupyv}`
cupy1s="$?"
echo "cuda-python installed `${pypip} show cuda-python`"
}

cuda_python
