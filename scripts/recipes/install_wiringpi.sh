#!/bin/bash

# Uninstall official wiringpi deb package
apt-get -y remove wiringpi
DIR=/usr/local/include
cd $ZYNTHIAN_SW_DIR

# Remove previous sources
if [ -d "./WiringPi" ]; then
	rm -rf "./WiringPi"
fi

# Download, build and install WiringPi library
#git clone https://github.com/WiringPi/WiringPi.git
git clone https://github.com/zynthian/WiringPi.git
cd WiringPi

if [ ! -d "$DIR" ];
then
	mkdir -p "$DIR"
fi

./build
cd ..
