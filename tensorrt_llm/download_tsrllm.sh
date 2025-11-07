#!/usr/bin/env bash
#author:rangapv@yahoo.com
#07-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

install_git_lfs() {
glfs1=`curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash`
glfs2=`sudo $cm1 install git-lfs`
}

download() {
dwn1=`git clone https://github.com/NVIDIA/TensorRT-LLM.git`
dwn2=`cd TensorRT-LLM;git submodule update --init --recursive;git lfs pull`
}

install_git_lfs
download
