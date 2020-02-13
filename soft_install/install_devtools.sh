#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

get_local "virtualbox.deb" "https://download.virtualbox.org/virtualbox/6.1.2/virtualbox-6.1_6.1.2-135662~Ubuntu~bionic_amd64.deb"

install_lpkg    \
    dia         \
    virtualbox

get_local "google_key.pub" "https://dl-ssl.google.com/linux/linux_signing_key.pub"
sudo apt-key add "$PKG_ARCHIVE/google_key.pub"

sudo usermod -aG vboxusers "$USER"

get_local "virtualbox.vbox-extpack" "https://download.virtualbox.org/virtualbox/6.1.2/Oracle_VM_VirtualBox_Extension_Pack-6.1.2.vbox-extpack"
xdg-open "$PKG_ARCHIVE/virtualbox.vbox-extpack" &
