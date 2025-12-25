#!/usr/bin/env bash
#author:rangapv@yahoo.com
#25-12-25

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
	     echo "The package $p is installed in the system with version# $res1"
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
         echo "$output"

    fi
fi
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
    echo "\"$p\" is installed @ $pwc proceeding with other checks"
fi

if (( pinsdep == ptcmd ))
then
        echo "All the dependecy \" ${pip11i[@]} \" are installed"
fi

done
}


nvidia_eco nccl libzmq3-dev libssl-dev libopenmpi-dev libzmq3-dev libnccl2 libnccl-dev libnuma-dev

pipifinsta onnx onnxruntime-gpu

nvidia_system tensorrt tensorrt_llm
