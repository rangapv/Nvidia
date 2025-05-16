#!/usr/bin/env bash
#author:rangapv@yahoo.com
#15-05-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

echo "echo $cm1"
driver() {
	pre1=`sudo ${cm1} -y update`
	pre2=`sudo ${cm1} install -y python3-pip vim`
	echo "pip and vim install status is ${pre2}"
	pre3=`pip3 install torch`
	echo "pytorch install status is ${pre3}"
        pre5=`sudo ${cm1} -y update`
        pre6=`sudo ${cm1} install -y nvidia-driver-535`
	echo "Drivr install status is ${pre6}"
}

driver

echo "REBOOT the system for the installs to work and then call the check1.sh program in this directory to VERIFY.."
