#!/bin/bash

FBXSDKNAME="fbxsdk"

pushd "/tmp"

sudo wget -O "${FBXSDKNAME}.tar.gz" -nc "https://www.autodesk.com/content/dam/autodesk/www/adn/fbx/2020-1-1/fbx202011_fbxsdk_linux.tar.gz"
sudo tar xvzf "${FBXSDKNAME}.tar.gz"
sudo rm "${FBXSDKNAME}.tar.gz"

sudo rm -rf "/opt/${FBXSDKNAME}"
sudo mkdir -p "/opt/${FBXSDKNAME}"

sudo ./fbx202011_fbxsdk_linux "/opt/${FBXSDKNAME}" << EOF
yes
n
EOF

sudo chmod -R 755 "/opt/${FBXSDKNAME}"

popd

echo "/opt/${FBXSDKNAME}/lib/gcc/x86/release" | sudo tee "/etc/ld.so.conf.d/fbxsdk-x86.conf"
echo "/opt/${FBXSDKNAME}/lib/gcc/x64/release" | sudo tee "/etc/ld.so.conf.d/fbxsdk-x86_64.conf"
sudo ldconfig