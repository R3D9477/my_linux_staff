#!/bin/bash

function fix_plasma() {
    if [ -f "/usr/bin/latte-dock" ]; then
        /usr/bin/latte-dock --replace &
    fi

    if [ -f "/opt/viber/Viber" ]; then
        killall -SIGKILL Viber
        /opt/viber/Viber %U &
    fi

    #/usr/bin/kstart5 -- plasmashell --replace      # --- I don't recommend to use it at startup time, because somethimes it hangs
    #/usr/bin/kquitapp5 plasmashell                 # --- I also don't recommend to use it at startup time, because somethimes it hangs, too

    killall -SIGKILL plasmashell
    /usr/bin/kstart5 -- plasmashell --replace

    /usr/bin/kstart5 -- kwin --replace
}

/usr/bin/dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member=PrepareForSleep" | while read x; do
    case "$x" in
        *"boolean false"*) fix_plasma   ;;
    esac
done
