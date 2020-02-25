#!/bin/bash

qdbus org.kde.keyboard /Layouts setLayout "us"

cp "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc.bck"

function fix_suspended_compositor() {

    sleep 3s # wait 3s until target application will not be launched
    kstart5 -- kwin --replace

    #### if uncomment second 2 steps then Compositor will not resume automatically
    #sleep 1s # wait 1s until KWin will not be loaded
    #qdbus org.kde.KWin /Compositor suspend
}

if ! $(qdbus org.kde.KWin /Compositor active) ; then
    fix_suspended_compositor & # restart KWin if compositor is suspended to avoid it's freezing
fi
