#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

sudo add-apt-repository --no-update --yes ppa:maarten-fonville/android-studio

update_system

install_lpkg                    \
    openjdk-8-jdk               \
    openjdk-11-jre-headless     \
    android-studio
