#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

# COMMENTED TO INSTALL UBUNTU RECOMMENDED DRIVERS:
#exportdefvar NVIDIA_DRIVER_VERSION "450" # LTS version

#------------------------------------------------------------------------------------------------------

if ! [[ -z "${NVIDIA_DRIVER_VERSION}" ]] ; then
    sudo add-apt-repository --no-update --yes ppa:graphics-drivers/ppa
fi

get_local "phoronix-test-suite.deb" "http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.0.1_all.deb"

update_system

install_lpkg                \
    libvulkan1              \
    libvulkan1:i386         \
    vulkan-utils            \
    mesa-vulkan-drivers     \
    phoronix-test-suite     \
    libgl1-mesa-dev

if ! [[ -z "${NVIDIA_DRIVER_VERSION}" ]] ; then
    install_lpkg            \
        nvidia-driver-$NVIDIA_DRIVER_VERSION
else
    "$SCRIPT_SRC_DIR/install_drivers_recommended.sh"
fi

#IFS='.' read -r -a NVIDIA_VERSION <<< $(apt-cache policy nvidia-driver-440 | grep Installed | cut -d ' ' -f4 | cut -d '-' -f1)
#if ( ! [ -z "${NVIDIA_VERSION[0]}" ] && ! [ -z "${NVIDIA_VERSION[1]}" ] ) ; then
    # update https://github.com/flathub/org.freedesktop.Platform.GL.nvidia
    # ...
#fi

kwriteconfig5 --file=$HOME/.config/plasmashellrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
kstart5 -- plasmashell --replace

kwriteconfig5 --file=$HOME/.config/kwinrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
kstart5 -- kwin --replace
