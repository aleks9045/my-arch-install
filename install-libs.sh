pacman -S --needed --noconfirm \
base-devel \
git \
curl \
wget \
unzip \
zip \
tar \
btop \
fastfetch \
neovim \
networkmanager \
bluez \
bluez-utils \
pipewire \
pipewire-pulse \
pipewire-alsa \
wireplumber \
pavucontrol \
mesa \
vulkan-intel \
intel-media-driver \
hyprland \
xdg-desktop-portal \
xdg-desktop-portal-hyprland \
waybar \
rofi-wayland \
kitty \
dunst \
libnotify \
pamixer \
swaync \
polkit \
wl-clipboard \
cliphist \
grim \
slurp \
brightnessctl \
playerctl \
nautilus \
firefox \
telegram-desktop \
ttf-dejavu \
noto-fonts \
noto-fonts-emoji \
ttf-jetbrains-mono-nerd \
qt5-wayland \
qt6-wayland \
nm-applet \
blueman && \
systemctl enable NetworkManager && \
systemctl enable bluetooth && \
runuser -l aleks -c 'git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si --noconfirm'