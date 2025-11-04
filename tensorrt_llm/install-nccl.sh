#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

#Refer: https://developer.nvidia.com/nccl

distro="${ki}${irelease}"
architecture="${ARCH}"

ncc1=`wget https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${architecture}/cuda-keyring_1.0-1_all.deb`
#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb

ncc2=`sudo dpkg -i cuda-keyring_1.0-1_all.deb`

ncc3=`sudo apt update`

ncc4=`sudo apt -y install libnccl2 libnccl-dev`
