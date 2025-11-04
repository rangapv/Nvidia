#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

install_dep1() {

deep1="$@"
for i in ${deep1}
do
	`sudo $cm1 install -y $i`
done

}

install_dep1 libssl-dev libnuma-dev
#install_dep1 libssl-dev libopenmpi-dev libzmq3-dev libnccl2 libnccl-dev libnccl2=2.28.7-1+cuda12.9 libnccl-dev=2.28.7-1+cuda12.9 libucx-dev libnuma-dev
