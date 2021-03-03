#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

install_lpkg                \
    build-essential         \
    cmake                   \
    extra-cmake-modules     \
    libkdecorations2-dev    \
    libkf5plotting-dev      \
    libqt5svg5-dev          \
    libkf5xmlgui-dev        \
    kio-dev                 \
    kinit-dev               \
    libkf5newstuff-dev      \
    kdoctools-dev           \
    libkf5notifications-dev \
    qtdeclarative5-dev      \
    libkf5crash-dev         \
    gettext                 \
    libnova-dev             \
    libgsl-dev              \
    libraw-dev              \
    libkf5notifyconfig-dev  \
    wcslib-dev              \
    libqt5websockets5-dev   \
    xplanet                 \
    xplanet-images          \
    qt5keychain-dev         \
    libsecret-1-dev         \
    breeze-icon-theme
