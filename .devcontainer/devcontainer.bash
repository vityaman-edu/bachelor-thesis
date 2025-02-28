#!/bin/bash

set -e

PKGS=(
    typst
)

mkdir -p /devcontainer
cd /devcontainer

pacman --noconfirm -Syu

if [ ! -d /devcontainer/yay ]; then
    useradd -m -G wheel builder
    passwd -d builder
    chown -R builder:builder /devcontainer
    echo 'builder ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers

    pacman --noconfirm -S --needed base-devel git
    su - builder -c "git clone https://aur.archlinux.org/yay.git /devcontainer/yay"
    su - builder -c "cd /devcontainer/yay && makepkg -si --noconfirm"
fi

yay --noconfirm -Sy $PKGS
