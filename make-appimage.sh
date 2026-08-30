#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q mixxx | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/mixxx.svg
export DESKTOP=/usr/share/applications/org.mixxx.Mixxx.desktop
export USE_HOST_DRIVERS_EXPERIMENTAL=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /usr/bin/mixxx /usr/share/mixxx/*

# Turn AppDir into AppImage
quick-sharun --make-appimage
