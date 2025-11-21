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
    echo "\"$p\" is already installed @ $pwc proceeding with other checks"
else
        echo "Going to install the package $p now"
	pwcp1=`pip3 install -y $p`
	pwcp1s="$?"
	    if [[ ( $pwcp1s == "0" ) ]]
	    then
		    echo "Successfully installed the package \[$p\]"
		    ((pinsdep++))
	    else
		    echo "Install of \[$p\] Failed"
	    fi
fi

if (( pinsdep == ptcmd ))
then
        echo "All the dependecy \" ${pip11i[@]} \" are installed"
fi

done
}

#pipifinsta torch
