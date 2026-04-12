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
wget https://distribute.re-volt.io/packs/rvgl_linux.zip

mkdir -p ./AppDir/bin
bsdtar -xvf rvgl_launcher_linux.zip -C ./AppDir/bin
case "$ARCH" in # they use 64 and arm64
	x86_64)  farch=64;;
	aarch64) farch=arm64;;
esac
bsdtar -xvf rvgl_linux.zip -C /usr/lib --strip-components 2 lib/lib${farch}/libunistring.so.2
