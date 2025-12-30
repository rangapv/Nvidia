#!/usr/bin/env bash
#author:rangapv@yahoo.com
#25-12-25

cudap=0
cuDNNp=0
tensorrtp=0
tensorrt_llmp=0
onnxp=0
onnxruntime_gpup=0


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
	  if [[ ( "$p" == "cuDNN" ) ]]
	  then
              checkpg "dpkg -l" $p    
          else
              checkpg "dpkg-query -W" $p 
	  fi
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
     res1="$(python3 -c "import ${p}; print(${p}.__version__)") >>/dev/null 2>&1"
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
    #echo "*******"
    #echo "1 is $1 and 2 is $2"
    #echo "*******"
    if [[ ($outps != 0) ]]
    then
         echo "Looks like the package $2 is missing"
         echo "$output"
    else
        #echo "$output"
        flag_setting dummy $2 $output 
    fi
fi
}


flag_setting() {
if [[ "$2" = "onnxruntime-gpu" ]]
then
	set $2 "onnxruntime_gpu"
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

nvidia_eco cuda cuDNN tensorrt
#nvidia_eco cuda cuDNN tensorrt nccl libzmq3-dev libssl-dev libopenmpi-dev libzmq3-dev libnccl2 libnccl-dev libnuma-dev
pipifinsta onnx onnxruntime-gpu
nvidia_system tensorrt_llm

echo ""
echo "1 indicates the package is installed; 0 is otherwise"
echo ""

echo "cuda is $cudap to check the version \"nvcc -V\" or python3 -c \"import cuda.bindings; print(cuda.bindings.__version__)\""
echo "cuDNN is $cuDNNp to check the version \"dpkg -l | grep cuDNN\""
echo "tensorrt is $tensorrtp to check the version\"dpkg-query -W tensorrt\""
echo "tensorrt_llm is $tensorrt_llmp to check the version python3 -c \"import tensorrt_llm; print(tensorrt_llm.__version__)\""
echo "onnx is $onnxp to check the version \"pip3 show onnx\""
echo "onnxruntime-gpu is $onnxruntime_gpup to check the version \"pip3 show onnxruntime-gpu\""
