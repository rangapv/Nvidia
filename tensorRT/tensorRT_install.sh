#!/usr/bin/env bash
#author:rangapv@yahoo.com
#09-05-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

distro="${ki}${irelease}"
architecture="${ARCH}"

tensorrt_install_alt() {
# Download the tensorRT https://developer.nvidia.com/tensorrt
# https://developer.nvidia.com/tensorrt/download/10x
#una=x86_64
#ki=ubuntu
#cmd1=apt-get
#os="ubuntuxx04"
os="${ki}${irelease}"
#tag="10.x.x-cuda-x.x"

irelease=`cat /etc/*-release | grep DISTRIB_RELEASE | awk '{split($0,a,"=");print a[2]}' |  awk '{split($0,a,".");print a[1]a[2]}'`
version="10.x.x.x"
arch=$(uname -m)
#version="10.6.0.26"
cuda="cuda-12.2"

tensort_ins1="TensorRT-10.6.0.26.Linux.x86_64-gnu.cuda-11.8.tar.gz"
version=`echo "${tensort_ins1}" | awk '{split($0,a,"-");print a[2]}'| grep -Eo '^[0-9.]*' | sed 's/.$//'`

tensort_ins2=`echo "${tensort_ins1}" | grep -o "cuda-.*"`
tensort_ins3=${tensort_ins2:0:-7}
cuda="${tensort_ins3}"

#tar -xzvf TensorRT-${version}.Linux.${arch}-gnu.${cuda}.tar.gz
step1=`tar -xzvf TensorRT-${version}.Linux.${una}-gnu.${cuda}.tar.gz`
step2=`export LD_LIBRARY_PATH=<TensorRT-${version}/lib>:$LD_LIBRARY_PATH`
step3=`cd TensorRT-${version}/python`
step4=`python3 -m pip3 install tensorrt-*-cp3x-none-linux_x86_64.whl`
step51=`python3 -m pip3 install tensorrt_lean-*-cp3x-none-linux_x86_64.whl`
step52=`python3 -m pip3 install tensorrt_dispatch-*-cp3x-none-linux_x86_64.whl`
}

tensorRT_ins(){

tensorv="10.9.0"

cuda_version="nvcc -V"

tencuda=`echo "${cuda_version}" | grep "release" | awk '{split($0,a," "); print a[6]}'| cut -b 2-`

cudavma=`echo "$tencuda" | awk '{split($0,a,"."); print a[1]}'`
cudavmi=`echo "$tencuda" | awk '{split($0,a,"."); print a[2]}'`

echo "The tensorRT version to be installed is ${tensorv} , on ${ki} release ${irelease} in the Architecture ${architecture} and the cuda version is ${cuda_version}, if you need a different version of tensorRT other than ${tensorv} enter y"
read reps3

if [ "$reps3" == "y" ]
then
	echo "enter the tensorRT version now(format 9/10/11.x.x)"
	read tennv 
	cudav=${tennv}
fi
echo "Preparing to install tensorRT with version ${tensorv}"

tr1=`sudo wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/${tensorv}/local_repo/nv-tensorrt-local-repo-${distro}-${tensorv}-cuda-${cudavma}.${cudavmi}_1.0-1_${architecture}.deb`

tr2=`sudo dpkg -i ./nv-tensorrt-local-repo-${distro}-${tensorv}-cuda-${cudavma}.${cudavmi}_1.0-1_${architecture}.deb`

tr3=`sudo cp /var/nv-tensorrt-local-repo-${distro}-${tensorv}-cuda-${cudavma}.${cudavmi}/nv-tensorrt-local-*-keyring.gpg /usr/share/keyrings/`

tr4=`sudo apt-get -y update`

tr5=`sudo apt-get -y install tensorrt`

}


verify_tensorRT() {

verify1=`dpkg-query -W tensorrt`
verify1s="$?"

if [ "$verify1s" == "0" ]
then
 echo "TensorRT install successful"
 echo "The installed version is ${verify1}"
else
 echo "The install of tensorRT failed"
 echo "${verify1}"
fi

}

verify_tensorRT2() {

python3
>>> import tensorrt
>>> print(tensorrt.__version__)
>>> assert tensorrt.Builder(tensorrt.Logger())

}

tensorRT_ins

verify_tensorRT

verify_tensorRT2
