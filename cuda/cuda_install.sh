#!/usr/bin/env bash
#author:rangapv@yahoo.com
#08-05-25

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

cuda_inst(){

distro="${ki}${irelease}"
architecture="${ARCH}"
cudav="12.9.0"
cudamin_ver="575.51.03-1"

#double check cudav and cudamin_ver in this website
#https://developer.nvidia.com/cuda-12-9-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local

echo "The cuda version to be installed is ${cudav} , on ${ki} relaese ${irelease} in the Architecture ${architecture}, if you need a different version of cuda other than ${cudav} enter y "
read reps2
if [ "$reps2" == "y" ]
then
	echo "enter the cuda version now(format 11/12.x.x)"
	read cudn
	cudav=${cudn}
fi

echo "Pre-paring to install cuda version ${cudav}"

cudavma=`echo "$cudav" | awk '{split($0,a,"."); print a[1]}'`
cudavmi=`echo "$cudav" | awk '{split($0,a,"."); print a[2]}'`


cudadown="y"

if [[ ( -f "cuda-repo-${distro}-${cudavma}-${cudavmi}-local_${cudav}-${cudamin_ver}_amd64.deb" ) ]]
then
	echo "The file \"(cuda-repo-${distro}-${cudavma}-${cudavmi}-local_${cudav}-${cudamin_ver}_amd64.deb)\" is found in the directory"
	echo "Do you still need to Download the repo... ?"
	echo "Press \"y\" to proceed to Download or any-other key otherwise"
	read cudadown
fi

if [[ $cudadown == "y" ]]
then
cudi1=`sudo wget https://developer.download.nvidia.com/compute/cuda/${cudav}/local_installers/cuda-repo-${distro}-${cudavma}-${cudavmi}-local_${cudav}-${cudamin_ver}_amd64.deb`
fi

cudi2=`sudo dpkg -i cuda-repo-${distro}-${cudavma}-${cudavmi}-local_${cudav}-${cudamin_ver}_amd64.deb`
cudi3=`sudo cp /var/cuda-repo-${distro}-${cudavma}-${cudavmi}-local/cuda-*-keyring.gpg /usr/share/keyrings/`
cudi4=`sudo apt-get -y update`
cudi5=`sudo apt-get -y install cuda-toolkit-${cudavma}-${cudavmi}`
cudi5s="$?"

if [[ ("$cudi5s" == "0") ]]
then
       finally1=`sudo apt-get install -y nvidia-open`
       echo "export PATH=/usr/local/cuda-${cudavma}.${cudavmi}/bin:$PATH" >> ~/.bashrc
       echo "export LD_LIBRARY_PATH=/usr/local/cuda-${cudavma}.${cudavmi}/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
       `source $HOME/.bashrc`
else
	fix1cuda=`sudo apt-get -y install libnvidia-cfg1`
	fix2cuda=`sudo dpkg -i --force-overwrite /var/cache/apt/archives/libnvidia-cfg1_590.48.01-0ubuntu1_amd64.deb`
	fix3cuda=`sudo apt-get -y install cuda-toolkit-${cudavma}-${cudavmi}`
	finally1=`sudo apt-get install -y nvidia-open`
	echo "export PATH=/usr/local/cuda-${cudavma}.${cudavmi}/bin:$PATH" >> ~/.bashrc
        echo "export LD_LIBRARY_PATH=/usr/local/cuda-${cudavma}.${cudavmi}/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
        `source $HOME/.bashrc`

fi
}

cuda_verify() {

cudaver1=`nvcc -V`
cudaver1s="$?"

if [ "$cudaver1s" == "0" ]
then
	echo  "cuda with version ${cudav} install is SUCCESS ${cudaver1}"
else
	echo  "cuda with version ${cudav} FAILED"
fi
}

cuda_inst

cuda_verify

