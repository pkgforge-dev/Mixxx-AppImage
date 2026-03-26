#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
        kvantum         \
        lxqt-qtplugin   \
        mixxx           \
        pipewire-audio  \
        pipewire-jack   \
        portaudio       \
        qt6-multimedia  \
        qt6ct

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini
