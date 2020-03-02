#!/bin/bash

if [ ! -f "/tmp/plasma_fix.lock" ] ; then
    echo 1 > "/tmp/plasma_fix.lock"

    kstart5 -- kwin --replace
    sleep 1s # wait 1s until KWin will not be loaded
    qdbus org.kde.KWin /Compositor resume

    if [ -f "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" ]; then
        cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
        kstart5 -- plasmashell --replace # this action is needed to apply settings of desktop (to restore shortcuts position)
    fi

    rm "/tmp/plasma_fix.lock"
fi
