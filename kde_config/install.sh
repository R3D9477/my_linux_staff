#!/bin/bash

PLASMOIDS_DIR="${HOME}/.local/share/plasma/plasmoids"
mkdir -p "$PLASMOIDS_DIR"

mkdir -p "/tmp/kde/downloads"
pushd "/tmp/kde/downloads"
    wget -O "paneltransparencybutton.zip" "https://github.com/psifidotos/paneltransparencybutton/archive/0.2.0.zip"
    wget -O "applet-latte-separator.zip"  "https://github.com/psifidotos/applet-latte-separator/archive/v0.1.1.zip"
    wget -O "applet-latte-spacer.zip"     "https://github.com/psifidotos/applet-latte-spacer/archive/v0.3.0.zip"
    wget -O "174127-take_a_break.zip"     "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE0NjM1ODAwNzgiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjI1MzRkNzYyYWVkOTRjMTcxMjk5NDU4ODhmNGM3YWViOTFlM2U4NTliZDI2ZGIzZjNjZWM1ODYxYTExMjM3MzVhM2VhYmFjYWQ4MmIwNzc4MzYyMGExYTZiYjYyNGM1ZDMyYzQzZGY2YmE0ODk0MjUyOTkzYWFhNDBhZmM0ZmUwIiwidCI6MTU5NTY3ODY4MSwic3RmcCI6IjkzNWZiZmQ1MDhmODcyOGNjNzRhZTYyY2FlMGE5MmI0Iiwic3RpcCI6IjkzLjE3MS4xNjAuMTkwIn0.iIGTXnQxMJ8NkUpCdE6Hy39OII2T5-z6rEcv6Tc8Xc8/174127-take_a_break.plasmoid"

    for PLASMOID in *.zip ; do unzip $PLASMOID -d "$PLASMOIDS_DIR" ; done
popd

cp -R "local"/* "${HOME}/.local/"
cp -R "config"/* "${HOME}/.config/"

rm "${HOME}/.local/share/applications/defaults.list"
ln -s "${HOME}/.local/share/applications/mimeapps.list" "${HOME}/.local/share/applications/defaults.list"

rm "${HOME}/.config/mimeapps.list"
ln -s "${HOME}/.local/share/applications/mimeapps.list" "${HOME}/.config/"
