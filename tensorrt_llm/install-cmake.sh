#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

cmake1() {

cmv="3.27.0"
cmv1=`echo $cmv | (cut -d '.' -f 1,2)`
#echo "cmv1 is ${cmv1}"
cmakedown="y"

if [[ ( -f "cmake-${cmv}-linux-x86_64.tar.gz" ) ]]
then
	echo "The file \"{cmake-${cmv}-linux-x86_64.tar.gz}\" is found in the directory"
	echo "Do you still need to Download the repo... ?"
	echo "Press \"y\" to proceed to Download or any-other key otherwise"
	read cmakedown
fi

if [[ $cmakedown == "y" ]]
then
cmc1=`sudo wget https://cmake.org/files/v${cmv1}/cmake-${cmv}-linux-x86_64.tar.gz`
fi
#Reference https://cmake.org/files/v3.27/cmake-3.27.0-linux-x86_64.sh

cmc2=`sudo tar -xf ./cmake-${cmv}-linux-x86_64.tar.gz -C /opt/cmake-${cmv}-linux-x86_64`
cmc3=`sudo ln -sf /opt/cmake-${cmv}-linux-x86_64/bin/cmake /usr/local/bin/cmake`
echo "export PATH=/usr/local/bin/cmake:$PATH" >> ~/.bashrc
`source ~/.bashrc`
cmcs=`cmake --version`
cmcs1="$?"

if [[ $cmcs1 == "0" ]]
then
	echo "cmake install is a Success ${cmcs}"
else
	echo "cmake install failed"
fi
}

cmake1
