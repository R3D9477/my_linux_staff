#!/bin/bash

# some apps should be started with "US" layout
qdbus org.kde.keyboard /Layouts setLayout "us"

function fix_suspended_compositor() {

    if [ ! -f "/tmp/plasma_fix.lock" ] ; then
        echo 1 > "/tmp/plasma_fix.lock"

        # wait 10s until target application will not be launched
        # and compositor will not be suspended on demand
        sleep 10s

        if ! $(qdbus org.kde.KWin /Compositor active) ; then
            kstart5 -- kwin --replace
            sleep 1s # wait 1s until KWin will not be loaded
        fi

        rm "/tmp/plasma_fix.lock"
    fi
}

fix_suspended_compositor & # restart KWin if compositor is suspended to avoid it's freezing
