#!/bin/bash

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

sudo tee /etc/modprobe.d/blacklist-ideapad.conf <<< "blacklist ideapad_laptop"
sudo apt purge bcmwl-kernel-source

#sudo apt-get install mokutil && mokutil --sb-state
#sudo apt-get install git build-essential linux-headers-$(uname -r)
#pushd "/tmp"
#git clone "https://github.com/lwfinger/rtw88.git"
#pushd "rtw88"
#make
#sudo make install
#popd
#popd

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

sudo mkdir -p "/etc/X11/xorg.conf.d"
echo 'Section  "InputClass"
    Identifier  "touchpad overrides"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
EndSection' | sudo tee "/etc/X11/xorg.conf.d/99-synaptics-overrides.conf"

#echo '
#[Unit]
#Description=Fix Lenovo Touchpad
#After=suspend.target
#[Service]
#User=root
#Type=oneshot
#ExecStart=bash -c "modprobe -r i2c-hid && modprobe i2c-hid"
#TimeoutSec=0
#StandardOutput=syslog
#[Install]
#WantedBy=suspend.target
#' | sudo tee "/lib/systemd/system/lenovo_fix.service"

#sudo systemctl enable lenovo_fix

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

ORIG_CMDLINE="GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\""
NEW_CMDLINE="GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash initcall_blacklist=elants_i2c_driver_init\""
sudo sed -i "s#${ORIG_CMDLINE}#${NEW_CMDLINE}#g" '/etc/default/grub'
sudo update-grub

#

#sudo apt install innoextract
#sudo apt install fwupd
#sudo fwupdate -l
#sudo fwupdate -a 
