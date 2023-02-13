#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian Setup Script
# 
# Setup a Zynthian Box in a fresh raspbian-lite "buster" image
# 
# Copyright (C) 2015-2019 Fernando Moyano <jofemodo@zynthian.org>
#
#******************************************************************************
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# For a full copy of the GNU General Public License see the LICENSE.txt file.
# 
#******************************************************************************

#------------------------------------------------------------------------------
# Load Environment Variables
#------------------------------------------------------------------------------

source "zynthian_envars_extended.sh"

#------------------------------------------------
# Set default config
#------------------------------------------------

[ -n "$ZYNTHIAN_INCLUDE_RPI_UPDATE" ] || ZYNTHIAN_INCLUDE_RPI_UPDATE=no
[ -n "$ZYNTHIAN_INCLUDE_PIP" ] || ZYNTHIAN_INCLUDE_PIP=yes
[ -n "$ZYNTHIAN_CHANGE_HOSTNAME" ] || ZYNTHIAN_CHANGE_HOSTNAME=yes

[ -n "$ZYNTHIAN_SYS_REPO" ] || ZYNTHIAN_SYS_REPO="https://github.com/zynthian/zynthian-sys.git"
[ -n "$ZYNTHIAN_UI_REPO" ] || ZYNTHIAN_UI_REPO="https://github.com/zynthian/zynthian-ui.git"
[ -n "$ZYNTHIAN_ZYNCODER_REPO" ] || ZYNTHIAN_ZYNCODER_REPO="https://github.com/zynthian/zyncoder.git"
[ -n "$ZYNTHIAN_WEBCONF_REPO" ] || ZYNTHIAN_WEBCONF_REPO="https://github.com/zynthian/zynthian-webconf.git"
[ -n "$ZYNTHIAN_DATA_REPO" ] || ZYNTHIAN_DATA_REPO="https://github.com/zynthian/zynthian-data.git"
[ -n "$ZYNTHIAN_SYS_BRANCH" ] || ZYNTHIAN_SYS_BRANCH="stable"
[ -n "$ZYNTHIAN_UI_BRANCH" ] || ZYNTHIAN_UI_BRANCH="stable"
[ -n "$ZYNTHIAN_ZYNCODER_BRANCH" ] || ZYNTHIAN_ZYNCODER_BRANCH="stable"
[ -n "$ZYNTHIAN_WEBCONF_BRANCH" ] || ZYNTHIAN_WEBCONF_BRANCH="stable"
[ -n "$ZYNTHIAN_DATA_BRANCH" ] || ZYNTHIAN_DATA_BRANCH="stable"

#------------------------------------------------
# Update System & Firmware
#------------------------------------------------

# Hold kernel version 
#apt-mark hold raspberrypi-kernel

# Update System
#apk -y update --allow-releaseinfo-change
#apk -y dist-upgrade

# Install required dependencies if needed
apk add sudo parted gpgv
#htpdate

# Adjust System Date/Time
#htpdate -s www.pool.ntp.org wikipedia.org google.com

#------------------------------------------------
# Add Repositories
#------------------------------------------------

# # deb-multimedia repo
# echo "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list
# wget https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
# dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
# rm -f deb-multimedia-keyring_2016.8.1_all.deb

# # KXStudio
# wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
# dpkg -i kxstudio-repos_10.0.3_all.deb
# rm -f kxstudio-repos_10.0.3_all.deb

# # Zynthian
# wget -O - https://deb.zynthian.org/zynthian-deb.pub | apt-key add -
# echo "deb https://deb.zynthian.org/zynthian-stable buster main" > /etc/apt/sources.list.d/zynthian.list

# # Sfizz
# sfizz_url_base="http://download.opensuse.org/repositories/home:/sfztools:/sfizz:/develop/Raspbian_10"
# echo "deb $sfizz_url_base/ /" > /etc/apt/sources.list.d/sfizz-dev.list
# curl -fsSL $sfizz_url_base/Release.key | apt-key add -

# apk -y update
# apk -y dist-upgrade
# apk -y autoremove

#------------------------------------------------
# Install Required Packages
#------------------------------------------------

# System
#apk -y remove --purge isc-dhcp-client triggerhappy logrotate dphys-swapfile
apk add avahi-daemon dhcpcd-dbus usbutils usbmount exfat-utils
apk add xinit xserver-xorg-video-fbdev x11-xserver-utils xinput libgl1-mesa-dri vnc4server 
apk add xfwm4 xfwm4-themes xfce4-panel xdotool cpufrequtils

apk add wpasupplicant wireless-tools iw hostapd dnsmasq
apk add firmware-brcm80211 firmware-atheros firmware-realtek atmel-firmware firmware-misc-nonfree
#firmware-ralink

# Alternate XServer with some 2D acceleration
#apk add xserver-xorg-video-fbturbo
#ln -s /usr/lib/arm-linux-gnueabihf/xorg/modules/drivers/fbturbo_drv.so /usr/lib/xorg/modules/drivers

# CLI Tools
apk add raspi-config psmisc tree joe nano vim p7zip-full i2c-tools ddcutil
apk add fbi scrot mpg123  mplayer xloadimage imagemagick fbcat abcmidi
apk add evtest libts-bin # touchscreen tools
#apk install python-smbus (i2c with python)


# Lguyome45: remove for Raspberry pi 4, with this firmware, wifi does not work
# Non-free WIFI firmware for RBPi3
#wget https://archive.raspberrypi.org/debian/pool/main/f/firmware-nonfree/firmware-brcm80211_20161130-3+rpt3_all.deb
#dpkg -i firmware-brcm80211_20161130-3+rpt3_all.deb
#rm -f firmware-brcm80211_20161130-3+rpt3_all.deb

#------------------------------------------------
# Development Environment
#------------------------------------------------

#Tools
apk add git swig subversion pkg-config autoconf automake premake gettext intltool libtool libtool-bin cmake cmake-curses-gui flex bison ngrep qt5-qmake qt4-qmake qt5-default gobjc++ ruby rake xsltproc vorbis-tools zenity

# AV Libraries => WARNING It should be changed on every new debian version!!
apk add libavcodec58 libavformat58 libavutil56 libavresample4 libavformat-dev libavcodec-dev

# Libraries
apk add libfftw3-dev libmxml-dev zlib1g-dev fluid libfltk1.3-dev \
libfltk1.3-compat-headers libncurses5-dev liblo-dev dssi-dev libjpeg-dev libxpm-dev libcairo2-dev libglu1-mesa-dev \
libasound2-dev dbus-x11 jackd2 libjack-jackd2-dev a2jmidid laditools liblash-compat-dev libffi-dev \
fontconfig-config libfontconfig1-dev libxft-dev libexpat-dev libglib2.0-dev libgettextpo-dev libsqlite3-dev \
libglibmm-2.4-dev libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev libreadline-dev \
lv2-c++-tools libxi-dev libgtk2.0-dev libgtkmm-2.4-dev liblrdf-dev libboost-system-dev libzita-convolver-dev \
libzita-resampler-dev fonts-roboto libxcursor-dev libxinerama-dev mesa-common-dev libgl1-mesa-dev \
libfreetype6-dev  libswscale-dev  libqt4-dev qtbase5-dev qtdeclarative5-dev libcanberra-gtk-module \
libcanberra-gtk3-module libxcb-cursor-dev libgtk-3-dev libxcb-util0-dev libxcb-keysyms1-dev libxcb-xkb-dev \
libxkbcommon-x11-dev libssl-dev libmpg123-0 libmp3lame0

#libjack-dev-session
#non-ntk-dev
#libgd2-xpm-dev

# Python
apk add python python-dev cython python-dbus python-setuptools
apk add python3 python3-dev cython3 python3-cffi python3-tk python3-dbus python3-mpmath python3-pil python3-pil.imagetk python3-setuptools python3-pyqt4 python3-numpy-dev python3-evdev 2to3

if [ "$ZYNTHIAN_INCLUDE_PIP" == "yes" ]; then
    apk add python-pip python3-pip
fi

pip3 install tornado==4.1 tornadostreamform websocket-client
pip3 install jsonpickle oyaml psutil pexpect requests
pip3 install mido python-rtmidi patchage rpi_ws281x
#mutagen

#************************************************
#------------------------------------------------
# Create Zynthian Directory Tree & 
# Install Zynthian Software from repositories
#------------------------------------------------
#************************************************

# Create needed directories
mkdir "$ZYNTHIAN_DIR"
mkdir "$ZYNTHIAN_CONFIG_DIR"
mkdir "$ZYNTHIAN_SW_DIR"

# Zynthian System Scripts and Config files
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_SYS_BRANCH}" "${ZYNTHIAN_SYS_REPO}"

# Install WiringPi
$ZYNTHIAN_RECIPE_DIR/install_wiringpi.sh

# Zyncoder library
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_ZYNCODER_BRANCH}" "${ZYNTHIAN_ZYNCODER_REPO}"
./zyncoder/build.sh

# Zynthian UI
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_UI_BRANCH}" "${ZYNTHIAN_UI_REPO}"
cd $ZYNTHIAN_UI_DIR
if [ -d "zynlibs" ]; then
	find ./zynlibs -type f -name build.sh -exec {} \;
else
	if [ -d "jackpeak" ]; then
		./jackpeak/build.sh
	fi
	if [ -d "zynseq" ]; then
		./zynseq/build.sh
	fi
fi

# Zynthian Data
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_DATA_BRANCH}" "${ZYNTHIAN_DATA_REPO}"

# Zynthian Webconf Tool
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_WEBCONF_BRANCH}" "${ZYNTHIAN_WEBCONF_REPO}"

# Create needed directories
#mkdir "$ZYNTHIAN_DATA_DIR/soundfonts"
#mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/sf2"
mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/sfz"
mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/gig"
mkdir "$ZYNTHIAN_MY_DATA_DIR"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/lv2"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx/banks"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx/presets"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/mod-ui"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/mod-ui/pedalboards"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata/generative"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata/synths"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/sf2"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/sfz"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/gig"
mkdir "$ZYNTHIAN_MY_DATA_DIR/snapshots"
mkdir "$ZYNTHIAN_MY_DATA_DIR/snapshots/000"
mkdir "$ZYNTHIAN_MY_DATA_DIR/capture"
mkdir "$ZYNTHIAN_MY_DATA_DIR/preset-favorites"
mkdir "$ZYNTHIAN_PLUGINS_DIR"
mkdir "$ZYNTHIAN_PLUGINS_DIR/lv2"

# Copy default snapshots
cp -a $ZYNTHIAN_DATA_DIR/snapshots/* $ZYNTHIAN_MY_DATA_DIR/snapshots/000

#************************************************
#------------------------------------------------
# System Adjustments
#------------------------------------------------
#************************************************

#Change Hostname
if [ "$ZYNTHIAN_CHANGE_HOSTNAME" == "yes" ]; then
    echo "zynthian" > /etc/hostname
    sed -i -e "s/127\.0\.1\.1.*$/127.0.1.1\tzynthian/" /etc/hosts
fi

# Run configuration script
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_data.sh
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh

# Configure Systemd Services
#systemctl daemon-reload
#rc-update add dhcpcd
#rc-update add avahi-daemon
#rc-update delete raspi-config
#rc-update delete cron
#rc-update delete rsyslog
#rc-update delete ntp
#rc-update delete htpdate
#rc-update delete wpa_supplicant
#rc-update delete hostapd
#rc-update delete dnsmasq
#rc-update delete unattended-upgrades
#rc-update delete apt-daily.timer
#systemctl mask packagekit
#systemctl mask polkit
#rc-update delete serial-getty@ttyAMA0.service
#rc-update delete sys-devices-platform-soc-3f201000.uart-tty-ttyAMA0.device
#rc-update add backlight
#rc-update add cpu-performance
rc-update add splash-screen
#rc-update add wifi-setup
rc-update add jack2
rc-update add mod-ttymidi
rc-update add a2jmidid
rc-update add zynthian
rc-update add zynthian-webconf
rc-update add zynthian-config-on-boot

# Setup loading of Zynthian Environment variables ...
echo "source $ZYNTHIAN_SYS_DIR/scripts/zynthian_envars_extended.sh" >> /root/.bashrc
# => Shell & Login Config
echo "source $ZYNTHIAN_SYS_DIR/etc/profile.zynthian" >> /root/.profile

# On first boot, resize SD partition, regenerate keys, etc.
$ZYNTHIAN_SYS_DIR/scripts/set_first_boot.sh


#************************************************
#------------------------------------------------
# Compile / Install Required Libraries
#------------------------------------------------
#************************************************

# Install some extra packages:
apk add jack-midi-clock midisport-firmware

# Install Jack2
$ZYNTHIAN_RECIPE_DIR/install_jack2.sh

# Install alsaseq Python Library
#$ZYNTHIAN_RECIPE_DIR/install_alsaseq.sh

# Install NTK library
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_ntk.sh

# Install pyliblo library (liblo OSC library for Python)
$ZYNTHIAN_RECIPE_DIR/install_pyliblo.sh

# Install mod-ttymidi (MOD's ttymidi version with jackd MIDI support)
$ZYNTHIAN_RECIPE_DIR/install_mod-ttymidi.sh

# Install LV2 lilv library
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_lv2_lilv.sh

# Install the LV2 C++ Tool Kit
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_lvtk.sh

# Install LV2 Jalv Plugin Host
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_lv2_jalv.sh

# Install Aubio Library & Tools
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_aubio.sh

# Install jpmidi (MID player for jack with transport sync)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_jpmidi.sh

# Install jack_capture (jackd audio recorder)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_jack_capture.sh

# Install jack_smf utils (jackd MID-file player/recorder)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_jack-smf-utils.sh

# Install touchosc2midi (TouchOSC Bridge)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_touchosc2midi.sh

# Install jackclient (jack-client python library)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_jackclient-python.sh

# Install QMidiNet (MIDI over IP Multicast)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_qmidinet.sh

# Install jackrtpmidid (jack RTP-MIDI daemon)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_jackrtpmidid.sh

# Install the DX7 SysEx parser
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_dxsyx.sh

# Install preset2lv2 (Convert native presets to LV2)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_preset2lv2.sh

# Install QJackCtl
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_qjackctl.sh

# Install the njconnect Jack Graph Manager
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_njconnect.sh

# Install Mutagen (when available, use pip3 install)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_mutagen.sh

# Install VL53L0X library (Distance Sensor)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_VL53L0X.sh

# Install MCP4748 library (Analog Output / CV-OUT)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_MCP4728.sh

# Install noVNC web viewer
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_noVNC.sh

# Install terminal emulator for tornado (webconf)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_terminado.sh

# Install DT overlays for waveshare displays and others
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_waveshare-dtoverlays.sh

#************************************************
#------------------------------------------------
# Compile / Install Synthesis Software
#------------------------------------------------
#************************************************

# Install ZynAddSubFX
#$ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
apk add zynaddsubfx

# Install Fluidsynth & SF2 SondFonts
apk add fluidsynth libfluidsynth-dev fluid-soundfont-gm fluid-soundfont-gs timgm6mb-soundfont
# Create SF2 soft links
ln -s /usr/share/sounds/sf2/*.sf2 $ZYNTHIAN_DATA_DIR/soundfonts/sf2

# Install Squishbox SF2 soundfonts
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_squishbox_sf2.sh

# Install Polyphone (SF2 editor)
#$ZYNTHIAN_RECIPE_DIR/install_polyphone.sh

# Install Sfizz (SFZ player)
#$ZYNTHIAN_RECIPE_DIR/install_sfizz.sh
apk add sfizz

# Install Linuxsampler
#$ZYNTHIAN_RECIPE_DIR/install_linuxsampler_stable.sh
apk add linuxsampler gigtools

# Install Fantasia (linuxsampler Java GUI)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_fantasia.sh

# Install setBfree (Hammond B3 Emulator)
#PORTREMOVED$ZYNTHIAN_RECIPE_DIR/install_setbfree.sh
# Setup user config directories
cd $ZYNTHIAN_CONFIG_DIR
mkdir setbfree
ln -s /usr/local/share/setBfree/cfg/default.cfg ./setbfree
cp -a $ZYNTHIAN_DATA_DIR/setbfree/cfg/zynthian_my.cfg ./setbfree/zynthian.cfg

# Install Pianoteq Demo (Piano Physical Emulation)
$ZYNTHIAN_RECIPE_DIR/install_pianoteq_demo.sh

# Install Aeolus (Pipe Organ Emulator)
#apk add aeolus
$ZYNTHIAN_RECIPE_DIR/install_aeolus.sh

# Install Mididings (MIDI route & filter)
apk add mididings

# Install Pure Data stuff
apk add puredata puredata-core puredata-utils python3-yaml \
pd-lua pd-moonlib pd-pdstring pd-markex pd-iemnet pd-plugin pd-ekext pd-import pd-bassemu pd-readanysf pd-pddp \
pd-zexy pd-list-abs pd-flite pd-windowing pd-fftease pd-bsaylor pd-osc pd-sigpack pd-hcs pd-pdogg pd-purepd \
pd-beatpipe pd-freeverb pd-iemlib pd-smlib pd-hid pd-csound pd-aubio pd-earplug pd-wiimote pd-pmpd pd-motex \
pd-arraysize pd-ggee pd-chaos pd-iemmatrix pd-comport pd-libdir pd-vbap pd-cxc pd-lyonpotpourri pd-iemambi \
pd-pdp pd-mjlib pd-cyclone pd-jmmmp pd-3dp pd-boids pd-mapping pd-maxlib

mkdir /root/Pd
mkdir /root/Pd/externals

#------------------------------------------------
# Install MOD stuff
#------------------------------------------------

#Install MOD-HOST
$ZYNTHIAN_RECIPE_DIR/install_mod-host.sh

# Install browsepy
$ZYNTHIAN_RECIPE_DIR/install_mod-browsepy.sh

#Install MOD-UI
$ZYNTHIAN_RECIPE_DIR/install_mod-ui.sh

#Install MOD-SDK
#$ZYNTHIAN_RECIPE_DIR/install_mod-sdk.sh

#------------------------------------------------
# Install Plugins
#------------------------------------------------
cd $ZYNTHIAN_SYS_DIR/scripts
#PORTREMOVED./setup_plugins_rbpi.sh

#------------------------------------------------
# Install Ableton Link Support
#------------------------------------------------
$ZYNTHIAN_RECIPE_DIR/install_hylia.sh
$ZYNTHIAN_RECIPE_DIR/install_pd_extra_abl_link.sh

#************************************************
#------------------------------------------------
# Final Configuration
#------------------------------------------------
#************************************************

# Create flags to avoid running unneeded recipes.update when updating zynthian software
if [ ! -d "$ZYNTHIAN_CONFIG_DIR/updates" ]; then
	mkdir "$ZYNTHIAN_CONFIG_DIR/updates"
fi

# Run configuration script before ending
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh

#************************************************
#------------------------------------------------
# End & Clean
#------------------------------------------------
#************************************************

#Block MS repo from being installed
#apt-mark hold raspberrypi-sys-mods
#touch /etc/apt/trusted.gpg.d/microsoft.gpg

# Clean
#apk -y autoremove # Remove unneeded packages
if [[ "$ZYNTHIAN_SETUP_APT_CLEAN" == "yes" ]]; then # Clean apt cache (if instructed via zynthian_envars.sh)
    apk cache clean
fi
