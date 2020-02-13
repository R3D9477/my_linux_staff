#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

get_local "vk.deb"                      "https://desktop.userapi.com/get_last?platform=linux64&branch=master&packet=deb"
get_local "steam.deb"                   "https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
get_local "viber.deb"                   "https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"
get_local "teamviewer.deb"              "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
get_local "megasync.deb"                "https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync_4.2.5+1.1_amd64.deb"
get_local "dolphin-megasync.deb"        "https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/dolphin-megasync_3.7.1+2.1_amd64.deb"
get_local "balena-etcher.deb"           "https://github.com/balena-io/etcher/releases/download/v1.5.73/balena-etcher-electron_1.5.73_amd64.deb"
get_local "vnc-viewer.deb"              "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.20.113-Linux-x64.deb"
get_local "googleearth.deb"             "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb"
get_local "virtualbox.deb"              "https://download.virtualbox.org/virtualbox/6.1.2/virtualbox-6.1_6.1.2-135662~Ubuntu~bionic_amd64.deb"
get_local "onlyoffice-desk.flatpakref"  "https://flathub.org/repo/appstream/org.onlyoffice.desktopeditors.flatpakref"

install_lpkg            \
    megasync            \
    dolphin-megasync    \
    onlyoffice-desk     \
    balena-etcher       \
    googleearth         \
    teamviewer          \
    vnc-viewer          \
    vokoscreen          \
    steam               \
    viber               \
    vk                  \
    qjoypad             \
    tuxguitar           \
    timidity            \
    tuxguitar-jsa       \
    tuxguitar-oss       \
    tuxguitar-alsa      \
    timidity-interfaces-extra

install_snap            \
    "skype --classic"
