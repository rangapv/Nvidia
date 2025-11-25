#!/usr/bin/env bash
#author:rangapv@yahoo.com
#07-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

install_git_lfs() {
glfs1=`curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash`
glfs2=`sudo $cm1 install git-lfs`
}

tsrllmv="v1.0.0"

echo "The version of tenorrt_LLM to be cloned ic ${tsrllmv}"
echo "if you need a different version press \"y\""
read tsrllmvn

if [[ ( "$tsrllmvn" == "y" ) ]]
then
	echo "Input the new version of tenosRT_LLM that needs to be installed now(v1.0.0,v0.16.0/..)"
	read newtsrllmv
	tsrllmv="${newtsrllmv}"
fi

download() {
dwn1=`git clone -b ${tsrllmv} https://github.com/NVIDIA/TensorRT-LLM.git`
dwn2=`cd TensorRT-LLM;git submodule update --init --recursive;git lfs install;git lfs pull`
}

install_git_lfs
download
