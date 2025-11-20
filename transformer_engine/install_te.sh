#!/usr/bin/env bash
#autho:rangapv@yahoo.com
#20-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/Nvidia/refs/heads/main/dep_inst.sh) > /dev/null 2>&1

inst_te() {

te1=`pip3 install --no-build-isolation transformer_engine[pytorch]`
te1s="$?"

if [[ ( $te1s == "0" ) ]]
then
	te11=`pip3 show tranformer-engine`
	echo "transformer-engine Install succeeded ${te11}"
else
	echo "tranformer-engine Install failed ${te1}"
fi
}

pipifinsta pybind11 jax
inst_te
