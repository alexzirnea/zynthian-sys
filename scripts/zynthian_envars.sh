#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian Environment Vars
# 
# Setup Zynthian Environment Variables
# 
# Copyright (C) 2015-2016 Fernando Moyano <jofemodo@zynthian.org>
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
# ****************************************************************************

export ZYNTHIAN_KIT_VERSION="Custom"

#Audio Config
export SOUNDCARD_NAME="Generic USB device"
export SOUNDCARD_CONFIG=""
export SOUNDCARD_MIXER="Speaker Left,Speaker Right"
export JACKD_OPTIONS="-P 70 -t 2000 -s -d alsa -d hw:2 -r 44100 -p 256 -n 2 -X raw"

#Display Config
export DISPLAY_NAME="RPi-Display 2.8"
export DISPLAY_CONFIG="dtoverlay=ili9341opizero,speed=48000000,rotate=270"
export DISPLAY_WIDTH="320"
export DISPLAY_HEIGHT="240"
export FRAMEBUFFER="/dev/fb0"

# Zynthian Wiring Config
export ZYNTHIAN_WIRING_LAYOUT="UART_ENCODERS"
export ZYNTHIAN_WIRING_ENCODER_A="4,5,6,7"
export ZYNTHIAN_WIRING_ENCODER_B="8,9,10,11"
export ZYNTHIAN_WIRING_SWITCHES="0,1,2,3"
export ZYNTHIAN_WIRING_MCP23017_INTA_PIN=""
export ZYNTHIAN_WIRING_MCP23017_INTB_PIN=""

# Zynthian Custom Switches
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01="MIDI_PROG_CHANGE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01__MIDI_NUM="1"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01__MIDI_CHAN="Active"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01__UI_SHORT="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01__UI_BOLD="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_01__UI_LONG="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02="MIDI_PROG_CHANGE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02__MIDI_NUM="2"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02__MIDI_CHAN="Active"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02__UI_SHORT="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02__UI_BOLD="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_02__UI_LONG="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03="MIDI_PROG_CHANGE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03__MIDI_NUM="3"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03__MIDI_CHAN="Active"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03__UI_SHORT="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03__UI_BOLD="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_03__UI_LONG="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04="MIDI_PROG_CHANGE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04__MIDI_NUM="4"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04__MIDI_CHAN="Active"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04__UI_SHORT="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04__UI_BOLD="NONE"
export ZYNTHIAN_WIRING_CUSTOM_SWITCH_04__UI_LONG="NONE"

# Zynthian UI Config
export ZYNTHIAN_UI_COLOR_BG="#000000"
export ZYNTHIAN_UI_COLOR_TX="#ffffff"
export ZYNTHIAN_UI_COLOR_ON="#ff0000"
export ZYNTHIAN_UI_COLOR_PANEL_BG="#3a424d"
export ZYNTHIAN_UI_FONT_FAMILY="Audiowide"
export ZYNTHIAN_UI_FONT_SIZE="10"
export ZYNTHIAN_UI_ENABLE_CURSOR="1"
export ZYNTHIAN_UI_TOUCH_WIDGETS="1"
export ZYNTHIAN_UI_RESTORE_LAST_STATE="0"
export ZYNTHIAN_UI_SNAPSHOT_MIXER_SETTINGS="0"
export ZYNTHIAN_UI_SWITCH_BOLD_MS="300"
export ZYNTHIAN_UI_SWITCH_LONG_MS="2000"

# MIDI system configuration
export ZYNTHIAN_SCRIPT_MIDI_PROFILE="/zynthian/config/midi-profiles/default.sh"

# Extra features
export ZYNTHIAN_WIFI_MODE="off"
export ZYNTHIAN_AUBIONOTES_OPTIONS="-O complex -t 0.5 -s -88  -p yinfft -l 0.5"
#export ZYNTHIAN_AUBIONOTES_OPTIONS="-O hfc -t 0.5 -s -60 -p yinfft -l 0.6"

# Directory Paths
export ZYNTHIAN_DIR="/zynthian"
export ZYNTHIAN_CONFIG_DIR="$ZYNTHIAN_DIR/config"
export ZYNTHIAN_SW_DIR="$ZYNTHIAN_DIR/zynthian-sw"
export ZYNTHIAN_UI_DIR="$ZYNTHIAN_DIR/zynthian-ui"
export ZYNTHIAN_SYS_DIR="$ZYNTHIAN_DIR/zynthian-sys"
export ZYNTHIAN_DATA_DIR="$ZYNTHIAN_DIR/zynthian-data"
export ZYNTHIAN_MY_DATA_DIR="$ZYNTHIAN_DIR/zynthian-my-data"
export ZYNTHIAN_EX_DATA_DIR="/media/usb0"
export ZYNTHIAN_RECIPE_DIR="$ZYNTHIAN_SYS_DIR/scripts/recipes"
export ZYNTHIAN_PLUGINS_DIR="$ZYNTHIAN_DIR/zynthian-plugins"
export ZYNTHIAN_PLUGINS_SRC_DIR="$ZYNTHIAN_SW_DIR/plugins"
export LV2_PATH="/usr/lib/lv2:/usr/lib/arm-linux-gnueabihf/lv2:/usr/local/lib/lv2:$ZYNTHIAN_PLUGINS_DIR/lv2:$ZYNTHIAN_DATA_DIR/presets/lv2:$ZYNTHIAN_MY_DATA_DIR/presets/lv2"

# Hardware Architecture & Optimization Options
if [ "$ZYNTHIAN_FORCE_RBPI_VERSION" ]; then
	hw_architecture="armv7l"
	rbpi_version=$ZYNTHIAN_FORCE_RBPI_VERSION
else
	hw_architecture=`uname -m 2>/dev/null`
	if [ -e "/sys/firmware/devicetree/base/model" ]; then
		rbpi_version=`tr -d '\0' < /sys/firmware/devicetree/base/model`
	else
		rbpi_version=""
	fi
fi

if [ "$hw_architecture" = "armv7l" ]; then
	#Alwinner H3 SoC
	CPU="-mcpu=cortex-a7 -mtune=cortex-a7"
	FPU="-mfpu=neon-vfpv4"
	#CPU="${CPU} -Ofast" #Breaks mod-ttymidi build
	FPU="${FPU} -mfloat-abi=hard -mlittle-endian -munaligned-access -mvectorize-with-neon-quad -ftree-vectorize"
	CFLAGS_UNSAFE="-funsafe-loop-optimizations -funsafe-math-optimizations -ffast-math"
fi
export MACHINE_HW_NAME=$hw_architecture
export RBPI_VERSION=$rbpi_version
export CFLAGS="${CPU} ${FPU}"
export CXXFLAGS=${CFLAGS}
export CFLAGS_UNSAFE=""
export RASPI=true
#echo "Hardware Architecture: ${hw_architecture}"
#echo "Hardware Model: ${rbpi_version}"

# Setup / Build Options
export ZYNTHIAN_SETUP_APT_CLEAN="TRUE" # Set TRUE to clean /var/cache/apt during build, FALSE to leave alone
