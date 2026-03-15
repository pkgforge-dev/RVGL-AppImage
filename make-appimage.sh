#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=0.1.23.1030a3
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DEPLOY_GTK=1
export GTK_DIR=gtk-3.0
export DEPLOY_OPENGL=1
export DEPLOY_PYTHON=1

# Deploy dependencies
quick-sharun ./AppDir/bin/* /usr/lib/7zip/* /usr/lib/libopenal.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
