#!/bin/ash

dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile remove
