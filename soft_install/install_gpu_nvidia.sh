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

if [[ -z $(grep "GraphicsResetNotifications=true" ~/.config/plasmashellrc) ]]; then
    echo "" >> ~/.config/plasmashellrc
    echo "[QtQuickRendererSettings]" >> ~/.config/plasmashellrc
    echo "GraphicsResetNotifications=true" >> ~/.config/plasmashellrc
    echo "" >> ~/.config/plasmashellrc
fi

if [[ -z $(grep "GraphicsResetNotifications=true" ~/.config/kwinrc) ]]; then
    echo "" >> ~/.config/kwinrc
    echo "[QtQuickRendererSettings]" >> ~/.config/kwinrc
    echo "GraphicsResetNotifications=true" >> ~/.config/kwinrc
    echo "" >> ~/.config/kwinrc
fi
