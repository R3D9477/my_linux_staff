#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

update_system

install_lpkg                    \
    kcolorchooser               \
    kolourpaint                 \
    krita                       \
    inkscape

install_snap                    \
    gravit-designer             \
    "blender --classic"
