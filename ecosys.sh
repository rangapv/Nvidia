#!/usr/bin/env bash
#author:rangapv@yahoo.com
#25-12-25

cudap=0
cuDNNp=0
tensorrtp=0
tensorrtllmp=0
onnxp=0
onnxruntimegpup=0

nvidia_eco(){
nveco1=("$@")
nveco2="$#"

if [[ "$nveco2" < "1" ]]
then
   echo "The System needs eco-system components to check(cuda/cuDNN/ONNX/cmake/ninja...)"
   exit
else
  for p in "${nveco1[@]}"
  do
     checkpg "dpkg -l" $p    
  done
fi  
}

nvidia_system(){
nveco1=("$@")
nveco2="$#"

if [[ "$nveco2" < "1" ]]
then
   echo "The System needs eco-system components to check(cuda/cuDNN/ONNX/cmake/ninja...)"
   exit
else
  for p in "${nveco1[@]}"
  do
     res1="$(python3 -c "import ${p}; print(${p}.__version__)")"
     res1s="$?"
     if [[ ( "$res1s" == "0" ) ]]
     then
	     #echo "The package $p is installed in the system with version# $res1"
	     flag_setting dummy $p $res1
     else
	     echo "The package $p is missing"
     fi
  done
fi
}

checkpg() {
checkargt=("$#")

if [[ "$checkargt" > "3" ]]
then
    echo "This function checkpkg should be called with only 2 arguments"
    echo "$checkargt"
else
    output=`$1 | grep $2`
    outps="$?"
    if [[ ($outps != 0) ]]
    then
         echo "Looks like the package $2 is missing"
         echo "$output"
    else
   #     echo "$output"
        flag_setting dummy $2 $output 
    fi
fi
}


flag_setting() {
if [[ "$2" = "onnxruntime-gpu" ]]
then
	set $2 "onnxruntimegpu"
fi

 #echo "2 is $2"
 v11="`set | grep -i ${2}p`"
 #echo "v11 is $v11"
 v12="`echo ${v11::-2}`"
 #v12="`echo $v11 | awk '{split($0,a,"=");print a[1]}'`"
 #echo "v11 after awk is $v12"
 local -n ref="$v12"
 ref="1"
 #echo "v12p is $ref"

}

pipifinsta() {
pip11i=("$@")
ptcmd="$#"
pinsdep=0

echo "the total pip package to check is $ptcmd"

for p in "${pip11i[@]}"
do

pwc=`pip3 show $p`
pwcs="$?"

if [[ ( $pwcs == "0" ) ]]
then
    #echo "\"$p\" is installed @ $pwc proceeding with other checks"
    flag_setting dummy $p $pwc
fi

if (( pinsdep == ptcmd ))
then
        echo "All the dependecy \" ${pip11i[@]} \" are installed"
fi

done
}

#nvidia_eco cuda cuDNN
nvidia_eco cuda cuDNN nccl libzmq3-dev libssl-dev libopenmpi-dev libzmq3-dev libnccl2 libnccl-dev libnuma-dev
pipifinsta onnx onnxruntime-gpu
nvidia_system tensorrt tensorrt_llm

echo "cuda is $cudap"
echo "cuDNN is $cuDNNp"
echo "tensorrt is $tensorrtp"
echo "tensorrt_llm is $tensorrtllmp"
echo "onnx is $onnxp"
echo "onnxruntime-gpu is $onnxruntimegpup"

