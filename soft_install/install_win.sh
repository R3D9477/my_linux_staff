#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

preAuthRoot
sudo dpkg --add-architecture i386

update_system

preAuthRoot
sudo add-apt-repository --no-update --yes multiverse
sudo add-apt-repository --no-update --yes ppa:lutris-team/lutris

#wget -O /tmp/Release.key "https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key"
#sudo apt-key add /tmp/Release.key
#sudo apt-add-repository --no-update --yes "deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./"

wget -O /tmp/public.gpg http://deb.playonlinux.com/public.gpg
sudo apt-key add /tmp/public.gpg
if [ -f "/etc/apt/sources.list.d/playonlinux.list" ]; then sudo rm "/etc/apt/sources.list.d/playonlinux.list" ; fi
sudo wget -nc http://deb.playonlinux.com/playonlinux_$UBUNTU_CODENAME.list -O /etc/apt/sources.list.d/playonlinux.list

update_system

install_lpkg        \
    wine64          \
    winetricks      \
    playonlinux     \
    lutris
