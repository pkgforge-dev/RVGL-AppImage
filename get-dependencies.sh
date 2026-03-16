#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    enet             \
    gtk3             \
    libdecor         \
    libunistring     \
    openal           \
    python           \
    python-packaging \
    python-requests  \
    python-wxpython  \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
wget https://rvgl.org/downloads/rvgl_launcher_linux.zip
wget https://distribute.re-volt.io/packs/rvgl_linux.zip

mkdir -p ./AppDir/bin
bsdtar -xvf rvgl_launcher_linux.zip -C ./AppDir/bin
if [ "$ARCH" = "x86_64" ]; then
    bsdtar -xvf rvgl_linux.zip -C ./AppDir/bin rvgl.64
else
    bsdtar -xvf rvgl_linux.zip -C ./AppDir/bin rvgl.arm64
fi
rm -rf ./AppDir/bin/icons
