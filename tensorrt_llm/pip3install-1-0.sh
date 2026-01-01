#!/usr/bin/env bash
#author:rangapv@yahoo.com
#01-01-26

echo "This are the fixes I encountered while installing the Built pip wheel for tensorrt_llm version 1.0.0"

built_pip(){

llm1=`pip3 install --upgrade onnx==1.19.1`
llm2=`pip3 install --upgrade pip`
llm3=`sudo wget https://storage.googleapis.com/ranga-tensorrt-llm/tensorrt_llm-1.0.0-cp310-cp310-linux_x86_64.whl`
llm4=`pip3 install ./tensorrt_llm-1.0.0-cp310-cp310-linux_x86_64.whl`

}

built_pip
