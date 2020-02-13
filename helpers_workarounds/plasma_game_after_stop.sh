#!/bin/bash

/usr/bin/qdbus org.kde.KWin /Compositor resume

if [ -f "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" ]; then
    /bin/cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
fi

/usr/bin/kstart5 -- plasmashell --replace
