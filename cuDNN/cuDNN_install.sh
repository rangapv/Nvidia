#!/usr/bin/env bash
#author:rangapv@yahoo.com
#07-05-25


source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1


cuda_cuDNN_alt() {

#irelease=`cat /etc/*-release | grep DISTRIB_RELEASE | awk '{split($0,a,"=");print a[2]}' |  awk '{split($0,a,".");print a[1]a[2]}'`
#pre-requistise install zlib getting it from my repo ansible-install source above ...calling the install here

vercheck 1.3.1 "python3 -c \"import zlib;print(zlib.ZLIB_RUNTIME_VERSION)\"" zlibadd
arch1="x86_64"
cudkey1=`wget https://developer.download.nvidia.com/compute/cuda/repos/${ki}${irelease}/${arch1}/cuda-keyring_1.1-1_all.deb`
cudkey2=`sudo dpkg -i cuda-keyring_1.1-1_all.deb`
update1=`sudo apt-get update`
update2=`sudo cp /var/cudnn-local-*/cudnn-*-keyring.gpg /usr/share/keyrings/`

#sudo apt-get -y install cudnn9-cuda-12
#if you have installed the CUDA tool-kit form this program then you would have had the key-ring & other packages installed
#cudnnv="12"
#get the cuda-tookkit Installed version
#
nvidia_version
cmd1="apt-get"
cuDNN=`sudo apt-get -y install cudnn9-cuda-${nvc22}`
echo "install is $cuDNN"
cuDNNsamp=`sudo ${cmd1} -y install libcudnn9-samples`
echo "sample output is $cuDNNsamp"
cuDNNdev=`sudo ${cmd1} -y install libcudnn9-dev`
echo "dev output is $cuDNNdev"
cudnn_version="9.6.0"
cuda_version="cuda${nvc21}"

#TO-PIN it to a particular verison uncomment the following
#sudo $cmd1 install libcudnn9=${cudnn_version}-1+${cuda_version}
#sudo $cmd1 install libcudnn9-dev=${cudnn_version}-1+${cuda_version}
#sudo $cmd1 install libcudnn9-samples=${cudnn_version}-1+${cuda_version}
}

cuda_cuDNN_inst() {

distro="${ki}${irelease}"
architecture="${ARCH}"
cdnv="9.6.0"
echo "The cuDNN version to be installed is ${cdnv} , on ${ki} relaese ${irelease} in the Architecture ${architecture}, if you need a different vrsion of cuDNN other than ${cdnv} enter y "
read reps1
if [ "$reps1" == "y" ]
then
	echo "enter the cuDNN version now(format 9.x.x)"
	read cdn
	cdnv=${cdn}
else
	echo "Continuing with the cuDNN version ${cdnv}"
fi

f1c=`sudo wget https://developer.download.nvidia.com/compute/cudnn/${cdnv}/local_installers/cudnn-local-repo-${distro}-${cdnv}_1.0-1_${architecture}.deb`
#break
f2c=`sudo dpkg -i ./cudnn-local-repo-${distro}-${cdnv}_1.0-1_${architecture}.deb`
f3c=`sudo cp /var/cudnn-local-*/cudnn-*-keyring.gpg /usr/share/keyrings/`
f4c=`sudo apt-get -y  update`
f5c=`sudo apt-get -y install cudnn`
#f6c=`sudo apt-get -y install libcudnn9-samples`
f6cpre=`sudo apt-get -y install libfreeimage3 libfreeimage-dev`

}


verify_cuDNN() {

vrcdnn1=`cp -r /usr/src/cudnn_samples_v9/ $HOME`
vrcdnn2=`cd $HOME/cudnn_samples_v9/mnistCUDNN;make clean && make`
vrcdnn3=`cd $HOME/cudnn_samples_v9/mnistCUDNN;./mnistCUDNN`
echo "the test result is $vrcdnn3"

}

cuda_cuDNN_inst
