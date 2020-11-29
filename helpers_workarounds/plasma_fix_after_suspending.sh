#!/bin/bash

function fix_access() {
    echo "<!DOCTYPE busconfig PUBLIC
\"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN\"
\"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd\">
<busconfig>
    <policy user="root">
        <allow eavesdrop="true"/>
        <allow eavesdrop="true" send_destination="*"/>
    </policy>
</busconfig>" | sudo tee "/etc/dbus-1/system-local.conf"
}

function killbyname () {
    PIDs=`pidof $(ps -aux | grep $1 | head -n 1 | awk '{print $11}')`
    kill ${PIDs}
}

function fix_plasma() {
    killapp plasmashell
    sleep 1s
    rm rm -rf /run/user/${UID}/kdeinit5*
    sleep 1s
    sync
    kstart5 plasmashell &
    sleep 3s
}

function fix_apps() {
    if [ ! -z "$(ps -aux | grep Viber)" ]; then
        kstart5 -- latte-dock --replace
    fi

    if [ ! -z "$(ps -aux | latte-dock)" ]; then
        killbyname Viber
        /opt/viber/Viber %U &
    fi

    if [ ! -z "$(ps -aux | MellowPlayer)" ]; then
        killbyname MellowPlayer
        ${HOME}/Applications/MellowPlayer*.AppImage %U &
    fi
}

dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member=PrepareForSleep" | while read x; do
    case "$x" in
        *"boolean false"*)
            if [ ! -f "/tmp/plasma_fix.lock" ] ; then
                echo 1 > "/tmp/plasma_fix.lock"
                fix_plasma
                fix_apps
                rm "/tmp/plasma_fix.lock"
            fi
        ;;
    esac
done
