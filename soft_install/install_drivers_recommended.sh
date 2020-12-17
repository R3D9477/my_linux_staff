#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

sudo ppa-purge -y ppa:graphics-drivers/ppa

update_system

install_lpkg                    \
    ubuntu-drivers-common

sudo apt-get remove -y nvidia-driver*

sudo ubuntu-drivers autoinstall
