#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

insta_ninja() {

ninjav="1.13.1"

ninjadown="y"

if [[ ( -f "ninja-linux.zip" ) ]]
then
	echo "The file \"ninja-linux.zip\" with version ${ninjav} is found in the directory"
	echo "Do you still need to Download the repo... ?"
	echo "Press \"y\" to proceed to Download or any-other key otherwise"
	read ninjadown
fi

if [[ $ninjadown == "y" ]]
then
ninj1=`sudo wget https://github.com/ninja-build/ninja/releases/download/v${ninjav}/ninja-linux.zip`
fi

#sudo wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/download/v1.13.1/ninja-linux.zip
ninj2=`sudo tar -xf ./ninja-linux.zip -d /usr/local/bin/ninja`

#sudo gunzip /usr/local/bin/ninja.gz

ninj3=`sudo chmod a+x /usr/local/bin/ninja`


ninj5=`sudo ln -s /usr/local/bin/ninja /usr/bin/ninja-build`

ninj4=`ninja --version`

ninj4s="$?"

if [[ $ninj4s == "0" ]]
then
	echo "Ninja Install a Success ${ninj4}"
else
	echo "Ninja Install failed"
fi

}

insta_ninja
