#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

exportdefvar ANDROID_NDK_PKG_NAME       "android-ndk-r21d-linux-x86_64"
exportdefvar NVIDIA_CODEWORKS_INSTALLER "`realpath ${DOWNLOADS_DIR}/CodeWorks*linux*.run`"

#--------------------------------------------------------------------------------------------------

preAuthRoot
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

show_message "INSTALL ANDROID NDK: ${ANDROID_NDK_PKG_NAME}"

if ! [ "${HOME}/Android/.ndk_installed" ] ; then
    get_local "${ANDROID_NDK_PKG_NAME}.zip" "https://dl.google.com/android/repository/${ANDROID_NDK_PKG_NAME}.zip"
    mkdir -p "${HOME}/Android"
    unzip "${PKG_ARCHIVE}/${ANDROID_NDK_PKG_NAME}.zip" -d "${HOME}/Android"
    touch "${HOME}/Android/.ndk_installed"
fi

#--------------------------------------------------------------------------------------------------

if [ -f "${NVIDIA_CODEWORKS_INSTALLER}" ] ; then

    if [[ "`lsb_release -i | awk '{print $3}'`" != "Ubuntu" ]] ; then

        U_RELEASE=`lsb_release -r | awk '{print $2}'`
        U_CODENAME=`lsb_release -c | awk '{print $2}'`

        if ! [ -f ".issue_bck" ]  ; then cp "/etc/issue" ".issue_bck" ; fi
        if ! [ -f ".os-release" ] ; then cp "/etc/os-release" ".os-release_bck" ; fi

        echo "Ubuntu ${U_RELEASE} \\n \\l" | sudo tee "/etc/issue"

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

    get_local    "libpng12.deb" "http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb"
    install_lpkg "libpng12.deb"

    show_message "INSTALL NVIDIA CODEWORKS: ${NVIDIA_CODEWORKS_INSTALLER}"

    chmod +x "${NVIDIA_CODEWORKS_INSTALLER}"
    exec "${NVIDIA_CODEWORKS_INSTALLER}"

    if [ -f ".issue_bck" ]      ; then sudo cp ".issue_bck" "/etc/issue" ; fi
    if [ -f ".os-release_bck" ] ; then sudo cp ".os-release_bck" "/etc/os-release" ; fi
fi
