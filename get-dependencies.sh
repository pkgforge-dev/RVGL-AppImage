#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    enet             \
    fluidsynth       \
    libdecor         \
    openal           \
    python           \
    python-packaging \
    python-requests  \
    python-wxpython  \
    sdl2_image

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package flac1.4

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
wget https://rvgl.org/downloads/rvgl_launcher_linux.zip

mkdir -p ./AppDir/bin
bsdtar -xvf rvgl_launcher_linux.zip -C ./AppDir/bin
