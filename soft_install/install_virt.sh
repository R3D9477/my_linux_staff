#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

preAuthRoot
#sudo add-apt-repository --no-update --yes ppa:morphis/anbox-support

echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${DIST_CODENAME} contrib" | sudo tee "/etc/apt/sources.list.d/vbox.list"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

update_system

install_lpkg linux-headers-generic

#------------------------------------------------------------------------------------------------------

install_lpkg virtualbox-6.1

preAuthRoot
sudo usermod -aG vboxusers "$USER"

get_local "virtualbox.vbox-extpack" "https://download.virtualbox.org/virtualbox/6.1.18/Oracle_VM_VirtualBox_Extension_Pack-6.1.18.vbox-extpack"
xdg-open "$PKG_ARCHIVE/virtualbox.vbox-extpack" &

#------------------------------------------------------------------------------------------------------

#install_lpkg                \
#    anbox-modules-dkms      \
#    android-tools-adb

#adb shell su -c "ip route add default dev eth0 via 192.168.250.1"
#adb shell su -c "ip rule add pref 32766 table main"
#adb shell su -c "ip rule add pref 32767 table local"

#preAuthRoot
#sudo modprobe ashmem_linux
#sudo modprobe binder_linux

#install_snap \
#    "anbox --devmode --beta"
