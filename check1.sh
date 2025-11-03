#!/usr/bin/env bash
#author:rangapv@yahoo.com
#05-05-25

chip_onboard() {

chklspci=`which lspci`
chklspcis="$?"
if [ "$chklspcis" != "0" ]
then
	echo "lspci NOT in this box"
else
	echo "lspci is installed in this box proceeding with checks"
	#echo "`lspci -v`"
fi
	
i1=`lspci | grep -i nvidia`
i1s="$?"

if [ "$i1s" == "1" ]
then
	echo "This system is not nvidia compatible"
	exit
else
	echo "This system is compatible ${i1}"
fi

}

nvd_smi() {
nvidsmi=`nvidia-smi`
snvidsmi="$?"
if [[ (( $snvidsmi -eq 0 )) ]]
then
        echo "Nvidia smi is $nvidsmi"
	echo "It is all good to go!"
else
	echo "Nvidia smi is not working"
fi
}


chkifinsta() {

cmd1=("$@")
tcmd="$#"
insdep=0

echo "the total depedency to check is $tcmd"

for i in "${cmd1[@]}"
do

wc=`which $i`
wcs="$?"

if [[ ( $wcs == "0" ) ]]
then
    echo "\"$i\" is installed @ $wc proceeding with other checks"
else
    echo "\"$i\"  is not installed .pls install it and then re-run this script for other tasks"
    insdep=1 
fi

done

if (( $insdep == 1 ))
then
   echo "Install all the dependencies and proceed after, exiting now"
   exit
else
   echo "All the dependecy \" ${cmd1[@]} \" are installed"
fi

}

dkms_stat() {
dk1=`which dkms`
dk1s="$?"

if [ "$dk1s" == "0" ]
then
	echo "dkms is installed @ $dk1 ..."
	echo "`dkms status`"
else
	echo "dkms is not installed"
fi

}



chip_onboard

nvd_smi

chkifinsta python3 pip3 gcc

dkms_stat

