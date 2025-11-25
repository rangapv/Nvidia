#!/usr/bin/env bash
#author:rangapv@yahoo.com
#07-11-25

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) > /dev/null 2>&1

ins_ucx() {
uc1=`git clone https://github.com/openucx/ucx.git`
uc11=`sudo mkdir /usr/local/bin/ucx`
uc12=`./ucx/autogen.sh`
uc21=`./ucx/contrib/configure-release --prefix=/usr/local/bin/ucx`
uc3=`./ucx/make -j8`
uc5=`/ucx/sudo make install`
uc51=`"export PATH=:/usr/local/bin/ucx/bin:$PATH" >> ~/.bashrc`
`source ~/.bashrc`
uc6=`ucx_info -v`
#openucx --version
echo "uc5 is $uc6"
}

ins_ucx
