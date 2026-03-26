#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
        kvantum         \
        lxqt-qtplugin   \
        pipewire-audio  \
        pipewire-jack   \
        portaudio       \
        qt6-multimedia  \
        qt6ct

if [ "$ARCH" = "x86_64" ]; then
    pacman -Syu --noconfirm mixxx
else
    make-aur-package mixxx-git
    #git clone https://gitlab.archlinux.org/archlinux/packaging/packages/mixxx
    #cd mixxx
    #useradd -m builder
    #echo "builder ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/builder
    #sudo chown -R builder:builder .
    #sudo -u builder makepkg -si --noconfirm
fi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
