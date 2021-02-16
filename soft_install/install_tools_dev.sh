#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

install_lpkg        \
    valgrind        \
    kcachegrind
