#!/usr/bin/env bash
#rangapv@yahoo.com
#20-11-25


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
else
    echo "\"$p\"  is not installed .pls install it and then re-run this script for other tasks"
    pinsdep=1
fi

done

if (( $pinsdep == 1 ))
then
   echo "Install all the dependencies and proceed after, exiting now"
   exit
else
   echo "All the dependecy \" ${pip11i[@]} \" are installed"
fi

}

pipifinsta torch
