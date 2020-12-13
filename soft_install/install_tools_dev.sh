#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

exportdefvar NVIDIA_CODEWORKS_INSTALLER "`realpath ${XDG_DESKTOP_DIR:-$HOME/Downloads}/CodeWorks*linux*.run`"

#--------------------------------------------------------------------------------------------------

sudo add-apt-repository --no-update --yes ppa:linuxuprising/java
sudo add-apt-repository --no-update --yes ppa:maarten-fonville/android-studio

update_system

install_lpkg                    \
    openjdk-8-jdk               \
    openjdk-11-jre-headless     \
    android-studio

install_lpkg                    \
    oracle-java15-installer

#--------------------------------------------------------------------------------------------------

if [ -f "${NVIDIA_CODEWORKS_INSTALLER}" ] ; then

    if [[ "`lsb_release -i | awk '{print $3}'`" != "Ubuntu" ]] ; then

        U_RELEASE=`lsb_release -r | awk '{print $2}'`
        U_CODENAME=`lsb_release -c | awk '{print $2}'`

        if ! [ -f "/tmp/issue" ] ; then
            cp "/etc/issue" "/tmp/issue"
            echo "Ubuntu ${U_RELEASE} \\n \\l" | sudo tee "/etc/issue"
        fi

        if ! [ -f "/tmp/os-release" ] ; then
            cp "/etc/os-release" "/tmp/os-release"
            echo "NAME=\"Ubuntu\"
VERSION=\"${U_RELEASE}\"
ID=ubuntu
ID_LIKE=\"ubuntu debian\"
PRETTY_NAME=\"Ubuntu ${U_RELEASE}\"
VARIANT=\"Ubuntu\"
VERSION_ID=\"${U_RELEASE}\"
VERSION_CODENAME=${U_CODENAME}
UBUNTU_CODENAME=${U_CODENAME}" | sudo tee "/etc/os-release"
        fi
    fi

    get_local    "libpng12.deb" "http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb"
    install_lpkg "libpng12.deb"

    "${NVIDIA_CODEWORKS_INSTALLER}"

    if [ -f "/tmp/issue" ]      ; then sudo cp "/tmp/issue" "/etc/issue" ; fi
    if [ -f "/tmp/os-release" ] ; then sudo cp "/tmp/os-release" "/etc/os-release" ; fi
fi
