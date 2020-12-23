#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

exportdefvar FBXSDKNAME "fbxsdk"

#--------------------------------------------------------------------------------------------------

pushd "/tmp"

    get_local "${FBXSDKNAME}.tar.gz" "https://www.autodesk.com/content/dam/autodesk/www/adn/fbx/2020-1-1/fbx202011_fbxsdk_linux.tar.gz"
    tar xvzf "${PKG_ARCHIVE}/${FBXSDKNAME}.tar.gz"

    preAuthRoot

    sudo rm -rf "/opt/${FBXSDKNAME}"
    sudo mkdir -p "/opt/${FBXSDKNAME}"
    sudo ./fbx202011_fbxsdk_linux "/opt/${FBXSDKNAME}" << EOF
yes
n
EOF

    preAuthRoot
    sudo chmod -R 755 "/opt/${FBXSDKNAME}"

popd

preAuthRoot
echo "/opt/${FBXSDKNAME}/lib/gcc/x86/release" | sudo tee "/etc/ld.so.conf.d/fbxsdk-x86.conf"
echo "/opt/${FBXSDKNAME}/lib/gcc/x64/release" | sudo tee "/etc/ld.so.conf.d/fbxsdk-x86_64.conf"
sudo ldconfig
