#!/bin/bash

# =========================================================
#                  ЗАПУСК ПОСЛЕ УСТАНОВКИ
# =========================================================
set -e

# Обновление системы
sudo pacman -Syu --needed --noconfirm

# AUR helper (yay)
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi


sudo pacman -S --needed --noconfirm \
base-devel git curl wget unzip zip tar \
btop fastfetch neovim vim \
networkmanager bluez bluez-utils \
pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol \
mesa vulkan-intel intel-media-driver \
hyprland xdg-desktop-portal xdg-desktop-portal-hyprland \
waybar rofi-wayland kitty \
dunst libnotify swaync \
polkit wl-clipboard cliphist grim slurp brightnessctl playerctl \
nautilus \
firefox telegram-desktop \
ttf-dejavu noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd \
qt5-wayland qt6-wayland \
nm-connection-editor blueman


yay -S --needed --noconfirm \
swaync


sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable --user pipewire pipewire-pulse wireplumber

echo "DONE"