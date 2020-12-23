#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

update_system

install_lpkg git autoconf baloo-kf5-dev bison breeze-dev build-essential bzr cmake cmake-data debhelper dh-apparmor doxygen extra-cmake-modules flex fontforge gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0 git gperf icu-devtools kded5-dev kgendesignerplugin kinit-dev kirigami2-dev kross-dev kscreenlocker-dev kwin-dev libaccounts-glib-dev libappstreamqt-dev libapr1 libaprutil1 libarchive-dev libasound2-dev libattr1-dev libboost-dev libbz2-dev libcanberra-dev libcap-dev libclang-3.9-dev libclang-dev libcln-dev libcups2-dev libcurl4-gnutls-dev libegl1-mesa-dev libepoxy-dev libexiv2-dev libfakekey-dev libfontconfig1-dev libfreetype6-dev libgbm-dev libgconf2-dev libgcrypt20-dev libgif-dev libglib2.0-dev libgmp-dev libgmpxx4ldbl libgpgme11-dev libgps-dev libgrantlee5-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgtk-3-dev libhunspell-dev libibus-1.0-dev libicu-dev libjpeg8-dev libjpeg-dev libjpeg-turbo8-dev libjson-perl libkaccounts-dev libkdecorations2-dev libkeduvocdocument-dev libkf5activities-dev libkf5activitiesstats-dev libkf5akonadicalendar-dev libkf5akonadicontact-dev libkf5akonadi-dev libkf5akonadimime-dev libkf5akonadinotes-dev libkf5akonadisearch-dev libkf5alarmcalendar-dev libkf5archive-dev libkf5attica-dev libkf5auth-dev libkf5baloowidgets-dev libkf5blog-dev libkf5bluezqt-dev libkf5bookmarks-dev libkf5calendarcore-dev libkf5calendarsupport-dev libkf5calendarutils-dev libkf5cddb-dev libkf5codecs-dev libkf5compactdisc-dev libkf5completion-dev libkf5config-dev libkf5configwidgets-dev libkf5contacteditor-dev libkf5contacts-dev libkf5coreaddons-dev libkf5crash-dev libkf5dbusaddons-dev libkf5declarative-dev libkf5dnssd-dev libkf5doctools-dev libkf5emoticons-dev libkf5eventviews-dev libkf5filemetadata-dev libkf5followupreminder-dev libkf5globalaccel-dev libkf5grantleetheme-dev libkf5gravatar-dev libkf5guiaddons-dev libkf5holidays-dev libkf5i18n-dev libkf5iconthemes-dev libkf5identitymanagement-dev libkf5idletime-dev libkf5imap-dev libkf5incidenceeditor-dev libkf5itemmodels-dev libkf5itemviews-dev libkf5jobwidgets-dev libkf5jsembed-dev libkf5kaddressbookgrantlee-dev libkf5kaddressbookimportexport-dev libkf5kcmutils-dev libkf5kdcraw-dev libkf5kdegames-dev libkf5kdelibs4support-dev libkf5kdepimdbusinterfaces-dev libkf5kexiv2-dev libkf5kgeomap-dev libkf5khtml-dev libkf5kio-dev libkf5kipi-dev libkf5kjs-dev libkf5kmahjongglib-dev libkf5konq-dev libkf5kontactinterface-dev libkf5ksieve-dev libkf5ldap-dev libkf5libkdepim-dev libkf5libkleo-dev libkf5mailcommon-dev libkf5mailimporter-dev libkf5mailtransport-dev libkf5mbox-dev libkf5mediaplayer-dev libkf5mediawiki-dev libkf5messagecomposer-dev libkf5messagecore-dev libkf5messagelist-dev libkf5messageviewer-dev libkf5mime-dev libkf5mimetreeparser-dev libkf5networkmanagerqt-dev libkf5newstuff-dev libkf5notifications-dev libkf5notifyconfig-dev libkf5package-dev libkf5parts-dev libkf5people-dev libkf5pimcommon-dev libkf5pimtextedit-dev libkf5plasma-dev libkf5plotting-dev libkf5prison-dev libkf5pty-dev libkf5purpose-dev libkf5qqc2desktopstyle-dev libkf5runner-dev libkf5sane-dev libkf5screen-dev libkf5sendlater-dev libkf5service-dev libkf5solid-dev libkf5sonnet-dev libkf5style-dev libkf5su-dev libkf5syndication-dev libkf5syntaxhighlighting-dev libkf5sysguard-dev libkf5templateparser-dev libkf5texteditor-dev libkf5textwidgets-dev libkf5threadweaver-dev libkf5tnef-dev libkf5unitconversion-dev libkf5vkontakte-dev libkf5wallet-dev libkf5wayland-dev libkf5webengineviewer-dev libkf5webkit-dev libkf5widgetsaddons-dev libkf5windowsystem-dev libkf5xmlgui-dev libkf5xmlrpcclient-dev libktorrent-dev liblcms2-dev liblmdb-dev libmlt-dev libmlt++-dev libnm-dev libnm-glib-dev libnm-util-dev libpackagekitqt5-dev libpam-dev libphonon4qt5-dev libphonon4qt5experimental-dev libpng-dev libpolkit-agent-1-dev libpolkit-backend-1-dev libpolkit-gobject-1-dev libpulse-dev libpwquality-dev libqalculate-dev libqca-qt5-2-dev libqimageblitz-dev libqrencode-dev libqt5sensors5 libqt5sensors5-dev libqt5svg5-dev libqt5texttospeech5-dev libqt5webkit5-dev libqt5x11extras5-dev libqt5xmlpatterns5-dev libqt5networkauth5-dev libraw1394-dev libscim-dev libserf-1-1 libsm-dev libssl-dev libsvn1 libtiff5-dev libudev-dev libusb-dev libvlccore-dev libvlc-dev libvncserver-dev libwww-perl libx11-dev libx11-xcb-dev libxapian-dev libxcb1-dev libxcb-composite0-dev libxcb-cursor0 libxcb-cursor-dev libxcb-damage0-dev libxcb-dpms0 libxcb-dpms0-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-record0-dev libxcb-render-util0-dev libxcb-res0 libxcb-res0-dev libxcb-screensaver0 libxcb-screensaver0-dev libxcb-shm0-dev libxcb-util0-dev libxcb-xf86dri0 libxcb-xf86dri0-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xtest0-dev libxcb-xv0 libxcb-xv0-dev libxcb-xvmc0 libxcb-xvmc0-dev libxcursor-dev libxft-dev libxi-dev libxkbfile-dev libxml2-dev libxml-parser-perl libxrender-dev libxslt1-dev libxslt-dev llvm llvm-3.9 modemmanager-dev modemmanager-qt-dev network-manager-dev openbox oxygen-icon-theme perl-modules pkg-config pkg-kde-tools plasma-workspace-dev po-debconf qml-module-qtquick* qt5-qmake qtbase5-dev qtbase5-dev-tools qtbase5-private-dev qtdeclarative5-dev qtmultimedia5-dev qtquickcontrols2-5-dev qtscript5-dev qttools5-dev qtxmlpatterns5-dev-tools shared-mime-info subversion texinfo xauth xcb-proto xserver-xorg-dev xserver-xorg-input-evdev-dev xserver-xorg-input-libinput-dev xserver-xorg-input-synaptics-dev xsltproc xvfb

preAuthRoot
sudo apt build-dep plasma-desktop plasma-workspace kwin -y

pushd "/tmp"

    if [ -d "kwin-lowlatency" ]; then rm -rf "kwin-lowlatency"; fi
    git clone "https://github.com/tildearrow/kwin-lowlatency.git"

    pushd "kwin-lowlatency"

        if git checkout "Plasma/${PLASMA_VERSION[0]}.${PLASMA_VERSION[1]}" ; then

            mkdir build
            cd build

            if cmake -DCMAKE_INSTALL_PREFIX="/usr" -DCMAKE_INSTALL_LIBDIR="lib/x86_64-linux-gnu" -DCMAKE_INSTALL_LIBEXECDIR="lib/x86_64-linux-gnu" -DBUILD_TESTING="OFF" .. ; then
                if make ; then
                    preAuthRoot
                    if sudo make install ; then
                        exit 0
                    fi
                fi
            fi
        fi

    popd

show_message "FAILED TO BUILD AND(OR) INSTALL KWIN-LOWLATENCY ${PLASMA_VERSION[0]}.${PLASMA_VERSION[1]}"

exit 1
