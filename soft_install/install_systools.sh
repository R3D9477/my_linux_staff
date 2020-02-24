#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

update_system

install_lpkg                    \
    htop                        \
    xterm                       \
    thefuck                     \
    yakuake                     \
    net-tools                   \
    ttf-dejavu                  \
    default-jre                 \
    rar unrar                   \
    ppa-purge                   \
    libarchive-zip-perl         \
    openssl1.0 libssl1.0-dev    \
    kdelibs5-dbg                \
    muon                        \
    kate                        \
    kfind                       \
    kcalc                       \
    ktorrent                    \
    kde-runtime                 \
    latte-dock                  \
    kdenetwork-filesharing      \
    partitionmanager            \
    kde-baseapps-bin            \
    software-properties-kde     \
    filelight                   \
    filezilla                   \
    samba                       \
    smbclient                   \
    libsmbclient                \
    python-smbc                 \
    python3-pydbus              \
    python3-construct           \
    kget                        \
    wget                        \
    lzip                        \
    unzip                       \
    squashfs-tools              \
    libgstreamer1.0-0           \
    gstreamer1.0-plugins-base   \
    gstreamer1.0-plugins-good   \
    gstreamer1.0-plugins-bad    \
    gstreamer1.0-plugins-ugly   \
    gstreamer1.0-libav          \
    gstreamer1.0-tools          \
    gstreamer1.0-x              \
    gstreamer1.0-alsa           \
    gstreamer1.0-gl             \
    gstreamer1.0-gtk3           \
    gstreamer1.0-qt5            \
    gstreamer1.0-pulseaudio     \
    ubuntu-restricted-extras    \
    linux-tools-common linux-tools-generic linux-tools-`uname -r`

if [ ! -f "/usr/bin/kdesu" ]; then
    sudo ln -s /etc/alternatives/kdesu /usr/bin/kdesu
fi
