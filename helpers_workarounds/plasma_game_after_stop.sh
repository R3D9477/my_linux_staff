#!/bin/bash

/usr/bin/kstart5 -- kwin --replace
sleep 1s
/usr/bin/qdbus org.kde.KWin /Compositor resume

if [ -f "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" ]; then
    /bin/cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    /usr/bin/kstart5 -- plasmashell --replace # this action needed to apply settings of desktop (to restore shortcuts position)
fi
