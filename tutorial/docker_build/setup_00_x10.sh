#!/bin/bash

#x10
mkdir -p ~/bin/x10
wget http://downloads.sourceforge.net/project/x10/x10/2.5.4/x10-2.5.4_linux_x86_64.tgz
tar zxf x10-2.5.4_linux_x86_64.tgz -C ~/bin/x10
echo 'export PATH=/home/oacis/bin/x10/bin:$PATH' >>~/.bash_profile
echo 'export JAVA_HOME=/usr/lib/jvm/default-java' >>~/.bash_profile
rm x10-2.5.4_linux_x86_64.tgz

