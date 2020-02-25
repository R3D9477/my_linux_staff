#!/bin/bash

function fix_plasma() {
    killall -9 plasmashell
    sleep 3s
    kstart5 -- plasmashell --replace
    kstart5 -- kwin --replace
}

function fix_apps() {
    if [ ! -z "$(pidof Viber)" ]; then
        kstart5 -- latte-dock --replace
    fi

    if [ ! -z "$(pidof latte-dock)" ]; then
        killall -9 Viber
        /opt/viber/Viber %U &
    fi
}

dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member=PrepareForSleep" | while read x; do
    case "$x" in
        *"boolean false"*)
            fix_plasma
            fix_apps
        ;;
    esac
done
