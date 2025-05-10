#!/usr/bin/env bash
#author:rangapv@yahoo.com
#10-05-25

pipi_nstall(){

cl=("$@")
cln="$#"
pipv="pip3"
inscnt=0

echo "the total pip packages to check is $cln"

for i in "${cl[@]}"
do
wc=`$pipv show $i`
wcs="$?"

if [[ ( $wcs != "0" ) ]]
then
    echo "\"$i\"  is not installed , proceeding to install the same with $pipv"
    ins_pippak=`$pipv install $i`
else
    echo "\"$i\" is installed proceeding with other checks"
fi
done

}

onnx_install() {

whonnx="$@"

if [ -z  "$@" ]
then
     onx_cpu=`pipi_nstall onnxruntime`
elif [ "$@" == "gpu" ]
then
     onx_gpu1=`pipi_nstall onnxruntime-gpu`

elif [ "$@" == "qnn" ]
then
     onx_qnn=`pipi_nstall onnxruntime-qnn`
else
	echo "No-compatible option to install ONNX runtime"
fi

torch_onnx=`python3 -c "import torch;print (torch.__version__)"`
tor_onxs="$?"

if [ "$tor_onxs" != "0" ]
then
  instor_onnx=`pipi_nstall torch`
fi

tflow_onnx=`python3 -c "import tf2onnx;print (tf2onnx.__version__)"`
tflow_onxs="$?"

if [ "$tflow_onxs" != "0" ]
then
  instflo_onnx=`pipi_nstall tf2onnx`
fi

skl2onnx_onnx=`python3 -c "import skl2onnx;print (skl2onnx.__version__)"`
skl2onnx_onxs="$?"

if [ "$skl2onnx_onxs" != "0" ]
then
  insskl_onnx=`pipi_nstall skl2onnx`
fi

}

verify_onnx() {
vrfonx=`pip3 show onnx`
vrfonxs="$?"

if [ "${vrfonxs}" == "0" ]
then
    echo "onnx runtime is installed in this box ${vrfonx}"
else
    echo "onnx runtime for Deeplearning is not installed "
fi

}


pipi_nstall onnx

onnx_install gpu

verify_onnx
