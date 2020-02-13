#!/bin/bash

/bin/cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck"

/usr/bin/qdbus org.kde.keyboard /Layouts setLayout "us"

/usr/bin/kstart5 -- kwin --replace

/usr/bin/qdbus org.kde.KWin /Compositor suspend
