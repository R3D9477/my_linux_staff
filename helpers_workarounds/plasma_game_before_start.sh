#!/bin/bash

/bin/cp ~/".config/plasma-org.kde.plasma.desktop-appletsrc" ~/".config/plasma-org.kde.plasma.desktop-appletsrc.bck"

CURRXKB='us,'$(setxkbmap -query | grep layout | cut -d ' ' -f6 | sed "s/,us//g" | sed "s/us,//g") ; setxkbmap us ; sleep .5s ; setxkbmap $CURRXKB

/usr/bin/kwin_x11 --replace &
sleep 1s

/usr/bin/qdbus org.kde.KWin /Compositor suspend
