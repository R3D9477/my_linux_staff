#!/bin/bash

cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck"

qdbus org.kde.keyboard /Layouts setLayout "us"

kstart5 -- kwin --replace
sleep 1s
qdbus org.kde.KWin /Compositor suspend
