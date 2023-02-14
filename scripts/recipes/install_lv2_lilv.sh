#!/bin/bash

# LV2, lilv and Python bindings
cd $ZYNTHIAN_SW_DIR

if [ -d lv2 ]; then
	rm -rf lv2
fi
git clone --recursive https://github.com/lv2/lv2.git
cd lv2
./waf configure
./waf build
./waf install
./waf clean

if [ ! -f "/usr/local/include/lv2.h" ]; then
	ln -s /usr/local/include/lv2/lv2.h /usr/local/include/lv2.h
fi

if [ ! -f "/usr/local/lib/pkgconfig/lv2core.pc" ]; then
	ln -s /usr/local/lib/pkgconfig/lv2.pc /usr/local/lib/pkgconfig/lv2core.pc
fi
cd ..

if [ -d serd ]; then
	rm -rf serd
fi
git clone --recursive https://github.com/drobilla/serd.git
cd serd
./waf configure
./waf build
./waf install
./waf clean
cd ..

if [ -d sord ]; then
	rm -rf sord
fi
git clone --recursive https://github.com/drobilla/sord.git
cd sord
./waf configure
./waf build
./waf install
./waf clean
cd ..

if [ -d sratom ]; then
	rm -rf sratom
fi
git clone --recursive https://github.com/lv2/sratom.git
cd sratom
./waf configure
./waf build
./waf install
./waf clean
cd ..


if [ -d lilv ]; then
	rm -rf lilv
fi
git clone --recursive https://github.com/lv2/lilv.git
cd lilv

#Get the destination directory
rm -rf /usr/local/lib/python3
python_dir=`find /usr/local/lib -type d -iname python3* | head -n 1`

./waf configure --python=/usr/bin/python3 --pythondir=$python_dir/dist-packages
./waf build
./waf install
./waf clean
cd ..

