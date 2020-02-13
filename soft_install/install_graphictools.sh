#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

sudo add-apt-repository --no-update --yes ppa:thomas-schiex/blender

update_system

install_lpkg                    \
    kcolorchooser               \
    kolourpaint                 \
    krita                       \
    inkscape                    \
    blender:amd64

install_snap                    \
    gravit-designer
