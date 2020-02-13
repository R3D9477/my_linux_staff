#!/bin/bash

NVIDIA_DRIVER_VERSION="440" # 08.02.2020 latest LTS version

#--------------------------------------------------------------------------------------------------

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

sudo add-apt-repository --no-update --yes ppa:graphics-drivers/ppa

update_system

install_lpkg                \
    libvulkan1              \
    libvulkan1:i386         \
    vulkan-utils            \
    mesa-vulkan-drivers     \
    phoronix-test-suite     \
    libgl1-mesa-dev         \
    nvidia-driver-$NVIDIA_DRIVER_VERSION

/usr/bin/kwriteconfig5 --file=$HOME/.config/plasmashellrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
/usr/bin/kstart5 -- plasmashell --replace

/usr/bin/kwriteconfig5 --file=$HOME/.config/kwinrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
/usr/bin/kwin_x11 --replace &
