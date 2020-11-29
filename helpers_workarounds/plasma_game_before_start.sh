#!/bin/bash

cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck"

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_SRC_DIR/plasma_app_before_start.sh

function suspend_compositor() {

    fix_suspended_compositor

    sleep 1s # wait 1s until KWin will not be loaded
    qdbus org.kde.KWin /Compositor suspend
}

suspend_compositor &
