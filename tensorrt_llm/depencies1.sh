#!/usr/bin/env bash
#author:rangapv@yahoo.com
#04-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

install_dep1() {

deep1="$@"
for i in ${deep1}
do
	dep1=`sudo $cm1 install -y $i`
	dep1s="$?"
	#echo "install of $i is $dep1s and cm1 is $cm1"

done

}

#install_dep1 libssl-dev libnuma-dev
install_dep1 libssl-dev libopenmpi-dev libzmq3-dev libnccl2 libnccl-dev libnuma-dev
#libnccl2=2.28.7-1+cuda12.9 libnccl-dev=2.28.7-1+cuda12.9 libucx-dev
