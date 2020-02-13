#!/bin/bash

/usr/bin/qdbus org.kde.KWin /Compositor resume

/bin/cp ~/".config/plasma-org.kde.plasma.desktop-appletsrc.bck" ~/".config/plasma-org.kde.plasma.desktop-appletsrc"

/usr/bin/kstart5 -- plasmashell --replace

if [ -z "$(ps -aux | grep plasmashell | grep slave-socket)" ] ; then
    /usr/bin/kstart5 plasmashell
fi
