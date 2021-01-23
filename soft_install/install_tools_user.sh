#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

preAuthRoot
wget -q -O - "https://dl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

sudo add-apt-repository --no-update --yes ppa:qbittorrent-team/qbittorrent-stable
sudo add-apt-repository --no-update --yes ppa:nilarimogard/webupd8

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list

#echo 'deb http://download.opensuse.org/repositories/home:/ColinDuquesnoy/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:ColinDuquesnoy.list
#curl -fsSL https://download.opensuse.org/repositories/home:ColinDuquesnoy/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home:ColinDuquesnoy.gpg > /dev/null

get_local "multiarch-support.deb"       "http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb"
get_local "libgnome-keyring-common.deb" "http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb"
get_local "libgnome-keyring0.deb"       "http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb"
get_local "vk.deb"                      "https://desktop.userapi.com/get_last?platform=linux64&branch=master&packet=deb"

get_local "libwxgtk30.deb"              "http://archive.ubuntu.com/ubuntu/pool/universe/w/wxwidgets3.0/libwxgtk3.0-0v5_3.0.4+dfsg-3_amd64.deb"

get_local "steam.deb"               "https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
get_local "viber.deb"               "https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"
get_local "discord.deb"             "https://discord.com/api/download?platform=linux&format=deb"
get_local "zoom.deb"                "https://zoom.us/client/latest/zoom_amd64.deb"
get_local "teamviewer.deb"          "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
get_local "balena-etcher.deb"       "https://github.com/balena-io/etcher/releases/download/v1.5.73/balena-etcher-electron_1.5.73_amd64.deb"
get_local "vnc-viewer.deb"          "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.20.113-Linux-x64.deb"
get_local "googleearth.deb"         "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb"
get_local "virtualbox.deb"          "https://download.virtualbox.org/virtualbox/6.1.2/virtualbox-6.1_6.1.2-135662~Ubuntu~bionic_amd64.deb"
get_local "Nextcloud.AppImage"      "https://github.com/nextcloud/desktop/releases/download/v3.1.0/Nextcloud-3.1.0-x86_64.AppImage"

update_system

install_lpkg                    \
    Nextcloud                   \
    libwxgtk30                  \
    woeusb                      \
    balena-etcher               \
    googleearth                 \
    teamviewer                  \
    vnc-viewer                  \
    vokoscreen                  \
    kamoso                      \
    steam                       \
    viber                       \
    vk                          \
    clamav                      \
    clamav-daemon               \
    qbittorrent                 \
    qjoypad                     \
    tuxguitar                   \
    timidity                    \
    tuxguitar-jsa               \
    tuxguitar-oss               \
    tuxguitar-alsa              \
    timidity-interfaces-extra   \
    onlyoffice-desktopeditors

sudo wget -nc -O "/usr/share/kservices5/ServiceMenus/clamtk-kde.desktop" "https://raw.githubusercontent.com/dave-theunsub/clamtk-kde/master/clamtk-kde.desktop"

install_snap        \
    "skype --classic"

install_flatpak     \
    "com.gitlab.ColinDuquesnoy.MellowPlayer"
