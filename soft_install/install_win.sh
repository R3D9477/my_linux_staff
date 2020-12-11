#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

sudo dpkg --add-architecture i386

update_system

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
