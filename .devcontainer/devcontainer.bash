#!/bin/bash

set -e

PKGS=(
    wget
    fontconfig
    typst
)

install_font() {
    FONT_DST=/usr/local/share/fonts

    FONT_FILE="$1"
    FONT_URL="$2"

    if [ ! -f "$FONT_DST/$FONT_FILE" ]; then
        mkdir -p "$FONT_DST"
        wget -q -O "$FONT_DST/$FONT_FILE" "$FONT_URL"
        fc-cache -fv
    fi
}

mkdir -p /devcontainer
cd /devcontainer

pacman --noconfirm -Syu

if [ ! -d /devcontainer/yay ]; then
    useradd -m -G wheel builder
    passwd -d builder
    chown -R builder:builder /devcontainer
    echo 'builder ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers

    pacman --noconfirm -S base-devel git
    su - builder -c "git clone https://aur.archlinux.org/yay.git /devcontainer/yay"
    su - builder -c "cd /devcontainer/yay && makepkg -si --noconfirm"
fi

for pkg in "${PKGS[@]}"; do
    yay --noconfirm -Sy $pkg
done

install_font "Times New Roman.ttf" https://github.com/justrajdeep/fonts/raw/refs/heads/master/Times%20New%20Roman.ttf
install_font "Times New Roman Bold.ttf" https://github.com/justrajdeep/fonts/blob/master/Times%20New%20Roman%20Bold.ttf
