#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

preAuthRoot
sudo ppa-purge -y ppa:graphics-drivers/ppa

update_system

install_lpkg                    \
    ubuntu-drivers-common

preAuthRoot
sudo apt-get remove -y nvidia-driver*

preAuthRoot
sudo ubuntu-drivers autoinstall
