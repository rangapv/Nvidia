#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

cmake1() {

cmv="3.27"
cmakedown="y"

if [[ ( -f "${cmake-${cmv}.0-Linux-x86_64.tar.gz}" ) ]]
then
	echo "The file \"${cmake-${cmv}.0-Linux-x86_64.tar.gz}\" is found in the directory"
	echo "Do you still need to Download the repo... ?"
	echo "Press \"y\" to proceed to Download or any-other key otherwise"
	read cmakedown
fi

if [[ $cmakedown == "y" ]]
then
cmc1=`sudo wget https://cmake.org/files/v${cmv}/cmake-${cmv}.0-Linux-x86_64.tar.gz`
fi

cmc2=`tar -xf ./cmake-${cmv}.0-Linux-x86_64.tar.gz -C /opt`
cmc3=`sudo ln -s /opt/cmake-3.27.x/bin/cmake /usr/local/bin/cmake`
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
