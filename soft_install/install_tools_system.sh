#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

sudo add-apt-repository --no-update --yes ppa:yannubuntu/boot-repair
sudo add-apt-repository --no-update --yes ppa:appimagelauncher-team/stable

update_system

install_lpkg                    \
    appimagelauncher            \
    boot-repair                 \
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
    muon                        \
    kate                        \
    kfind                       \
    kcalc                       \
    ktorrent                    \
    latte-dock                  \
    kdenetwork-filesharing      \
    partitionmanager            \
    filelight                   \
    filezilla                   \
    samba                       \
    smbclient                   \
    libsmbclient                \
    python3-pydbus              \
    python3-construct           \
    kget                        \
    wget                        \
    lzip                        \
    unzip                       \
    squashfs-tools              \
    exfat-fuse exfat-utils      \
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
    gnome-disk-utility          \
    linux-tools-common linux-tools-generic "linux-tools-`uname -r`"

#if ! [ -f "/usr/bin/kdesu" ]; then
#    sudo ln -s /etc/alternatives/kdesu /usr/bin/kdesu
#fi
