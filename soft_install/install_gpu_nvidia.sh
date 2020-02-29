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

IFS='.' read -r -a NVIDIA_VERSION <<< $(apt-cache policy nvidia-driver-440 | grep Installed | cut -d ' ' -f4 | cut -d '-' -f1)
if [ ! -z ${NVIDIA_VERSION[0]} ] && [ ! -z ${NVIDIA_VERSION[1]} ] ; then
    # update https://github.com/flathub/org.freedesktop.Platform.GL.nvidia
    # ...
fi

kwriteconfig5 --file=$HOME/.config/plasmashellrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
kstart5 -- plasmashell --replace

kwriteconfig5 --file=$HOME/.config/kwinrc --group="QtQuickRendererSettings" --key="GraphicsResetNotifications" true
kstart5 -- kwin --replace
