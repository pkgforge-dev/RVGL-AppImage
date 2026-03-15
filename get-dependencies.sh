#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    enet             \
    fluidsynth       \
    openal           \
    python-packaging \
    python-requests  \
    python-wxpython

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

# Comment this out if you need an AUR package
#make-aur-package flac1.4

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
bsdtar -xvf rvgl_linux.zip -C ./AppDir/bin rvgl.${farch}
bsdtar -xvf rvgl_linux.zip -C /usr/lib --strip-components 2 lib/lib${farch}/libunistring.so.2
rm -rf ./AppDir/bin/icons
