#!/bin/bash

sudo tee /etc/modprobe.d/blacklist-ideapad.conf <<< "blacklist ideapad_laptop"
sudo apt purge bcmwl-kernel-source

sudo mkdir -p "/etc/X11/xorg.conf.d"
echo '
Section  "InputClass"
    Identifier  "touchpad overrides"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
EndSection
' | sudo tee "/etc/X11/xorg.conf.d/99-synaptics-overrides.conf"

echo '
[Unit]
Description=Fix Lenovo Touchpad
After=suspend.target
[Service]
User=root
Type=oneshot
ExecStart=bash -c "modprobe -r i2c-hid && modprobe i2c-hid"
TimeoutSec=0
StandardOutput=syslog
[Install]
WantedBy=suspend.target
' | sudo tee "/lib/systemd/system/lenovo_fix.service"
