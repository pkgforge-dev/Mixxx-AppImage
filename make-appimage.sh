#!/bin/sh

set -eu

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    VERSION=$(pacman -Q mixxx | awk '{print $2; exit}')
else
    VERSION=$(pacman -Q mixxx-git | awk '{print $2; exit}')
fi
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/mixxx.svg
export DESKTOP=/usr/share/applications/org.mixxx.Mixxx.desktop
export DEPLOY_QT=1

# Deploy dependencies
quick-sharun /usr/bin/mixxx /usr/share/mixxx/*
# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
