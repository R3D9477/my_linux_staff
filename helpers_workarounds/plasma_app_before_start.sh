#!/bin/bash

# some apps should be started with "US" layout
qdbus org.kde.keyboard /Layouts setLayout "us"

function fix_suspended_compositor() {

    sleep 3s # wait 3s until target application will not be launched
    kstart5 -- kwin --replace
}

if ! $(qdbus org.kde.KWin /Compositor active) ; then
    fix_suspended_compositor & # restart KWin if compositor is suspended to avoid it's freezing
fi
