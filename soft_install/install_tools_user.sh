#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo add-apt-repository --no-update --yes ppa:qbittorrent-team/qbittorrent-stable
sudo add-apt-repository --no-update --yes ppa:nilarimogard/webupd8

echo 'deb http://download.opensuse.org/repositories/home:/ColinDuquesnoy/xUbuntu_18.04/ /' | sudo tee /etc/apt/sources.list.d/home:ColinDuquesnoy.list
curl -fsSL https://download.opensuse.org/repositories/home:ColinDuquesnoy/xUbuntu_18.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home:ColinDuquesnoy.gpg > /dev/null

get_local "vk.deb"                      "https://desktop.userapi.com/get_last?platform=linux64&branch=master&packet=deb"
get_local "steam.deb"                   "https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
get_local "viber.deb"                   "https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"
get_local "teamviewer.deb"              "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
get_local "balena-etcher.deb"           "https://github.com/balena-io/etcher/releases/download/v1.5.73/balena-etcher-electron_1.5.73_amd64.deb"
get_local "vnc-viewer.deb"              "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.20.113-Linux-x64.deb"
get_local "googleearth.deb"             "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb"
get_local "virtualbox.deb"              "https://download.virtualbox.org/virtualbox/6.1.2/virtualbox-6.1_6.1.2-135662~Ubuntu~bionic_amd64.deb"
get_local "onlyoffice-desk.deb"         "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb"

update_system

install_lpkg            \
    mellowplayer        \
    woeusb              \
    onlyoffice-desk     \
    balena-etcher       \
    googleearth         \
    teamviewer          \
    vnc-viewer          \
    vokoscreen          \
    kamoso              \
    steam               \
    viber               \
    vk                  \
    clamav              \
    clamav-daemon       \
    libclamunrar*       \
    qbittorrent         \
    qjoypad             \
    tuxguitar           \
    timidity            \
    tuxguitar-jsa       \
    tuxguitar-oss       \
    tuxguitar-alsa      \
    timidity-interfaces-extra

sudo wget -nc -O "/usr/share/kservices5/ServiceMenus/clamtk-kde.desktop" "https://raw.githubusercontent.com/dave-theunsub/clamtk-kde/master/clamtk-kde.desktop"

install_snap    \
    "skype --classic"
