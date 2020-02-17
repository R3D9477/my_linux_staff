#!/bin/bash

kstart5 -- kwin --replace
sleep 1s
qdbus org.kde.KWin /Compositor resume

if [ -f "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" ]; then
    cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    kstart5 -- plasmashell --replace # this action is needed to apply settings of desktop (to restore shortcuts position)
fi
