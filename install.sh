#!/bin/bash

set -euo pipefail

# =========================================================
#                     ПРОВЕРКИ
# =========================================================

if [[ $EUID -ne 0 ]]; then
    echo "Запустите скрипт от root"
    exit 1
fi

if [[ ! -d /sys/firmware/efi ]]; then
    echo "Система загружена НЕ в UEFI режиме"
    exit 1
fi

# =========================================================
#                     НАСТРОЙКИ
# =========================================================

DISK="/dev/nvme0n1"

# Разделы
BOOT_PART="${DISK}p5"     # EFI раздел Arch (FAT32)
ROOT_PART="${DISK}p6"     # /
HOME_PART="${DISK}p7"     # /home (НЕ форматируется)
WIN_EFI_PART="${DISK}p1"  # EFI раздел Windows (FAT32)

# Система
HOSTNAME="arch-vivo"
USERNAME="aleks"

# После установки лучше сменить
USER_PASSWORD="654987654"
ROOT_PASSWORD="654987654"

TIMEZONE="Europe/Moscow"

# =========================================================
#                     ИНФОРМАЦИЯ
# =========================================================

echo "========================================="
echo "         УСТАНОВКА ARCH LINUX"
echo "========================================="
echo "Диск: $DISK"
echo "EFI раздел: $BOOT_PART"
echo "Root раздел: $ROOT_PART"
echo "Home раздел: $HOME_PART"
echo "Windows EFI раздел: $WIN_EFI_PART"
echo
echo "Hostname: $HOSTNAME"
echo "Пользователь: $USERNAME"
echo "========================================="
echo "БУДЕТ ОТФОРМАТИРОВАН:"
echo "  - $ROOT_PART"
echo
echo "НЕ БУДУТ ТРОНУТЫ:"
echo "  - $HOME_PART"
echo "  - $BOOT_PART"
echo "========================================="

read -p "Продолжить? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Установка отменена."
    exit 1
fi

# =========================================================
#                     ПРОВЕРКА РАЗДЕЛОВ
# =========================================================

for part in "$BOOT_PART" "$ROOT_PART" "$HOME_PART" "$WIN_EFI_PART"; do
    if [[ ! -b "$part" ]]; then
        echo "Раздел не найден: $part"
        exit 1
    fi
done

# =========================================================
#                     ФОРМАТИРОВАНИЕ
# =========================================================

echo "[1/10] Форматирование root раздела..."

mkfs.ext4 -F "$ROOT_PART" -L ARCH_ROOT

# =========================================================
#                     МОНТИРОВАНИЕ
# =========================================================

echo "[2/10] Монтирование разделов..."

mount "$ROOT_PART" /mnt

mkdir -p /mnt/{boot,home,efi}

mount "$BOOT_PART" /mnt/boot
mount "$HOME_PART" /mnt/home
mount "$WIN_EFI_PART" /mnt/efi

# =========================================================
#                     УСТАНОВКА БАЗЫ
# =========================================================

echo "[3/10] Установка базовой системы..."

pacstrap -K /mnt \
    base \
    linux \
    linux-headers \
    linux-firmware \
    intel-ucode \
    base-devel \
    sudo \
    vim \
    networkmanager \
    iwd \
    grub \
    efibootmgr \
    os-prober \
    dosfstools \
    mtools \
    git \
    curl \
    wget \
    zsh \
    pipewire \
    pipewire-pulse \
    wireplumber \
    bluez \
    bluez-utils

# =========================================================
#                     FSTAB
# =========================================================

echo "[4/10] Генерация fstab..."

genfstab -U /mnt > /mnt/etc/fstab

# =========================================================
#                     НАСТРОЙКА СИСТЕМЫ
# =========================================================

echo "[5/10] Настройка системы..."

arch-chroot /mnt /bin/bash << EOF

set -e

# ---------------------------------------------------------
# Timezone
# ---------------------------------------------------------

ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# ---------------------------------------------------------
# Locale
# ---------------------------------------------------------

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen

echo "LANG=ru_RU.UTF-8" > /etc/locale.conf

echo "KEYMAP=ru" > /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

# ---------------------------------------------------------
# Hostname
# ---------------------------------------------------------

echo "$HOSTNAME" > /etc/hostname

cat > /etc/hosts << HOSTS
127.0.0.1 localhost
::1 localhost
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME
HOSTS

# ---------------------------------------------------------
# Root password
# ---------------------------------------------------------

echo "root:$ROOT_PASSWORD" | chpasswd

# ---------------------------------------------------------
# Пользователь
# ---------------------------------------------------------

useradd \
    -G wheel,audio,video,storage,optical \
    -s /bin/zsh \
    $USERNAME

echo "$USERNAME:$USER_PASSWORD" | chpasswd

# ---------------------------------------------------------
# Ownership существующего home
# ---------------------------------------------------------

chown -R $USERNAME:$USERNAME /home/$USERNAME

# ---------------------------------------------------------
# Очистка кэша
# ---------------------------------------------------------

rm -rf /home/$USERNAME/.cache

# ---------------------------------------------------------
# sudo
# ---------------------------------------------------------

echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

# ---------------------------------------------------------
# Службы
# ---------------------------------------------------------

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable systemd-timesyncd

EOF

# =========================================================
#                     GRUB
# =========================================================

echo "[6/10] Установка GRUB..."

arch-chroot /mnt grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot \
    --bootloader-id=GRUB \
    --recheck

echo "[7/10] Настройка GRUB..."

arch-chroot /mnt /bin/bash -c "
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
"

# =========================================================
#                     HYPRLAND
# =========================================================

echo "[8/10] Установка Hyprland..."

arch-chroot /mnt pacman -S --needed --noconfirm \
    hyprland \
    xdg-desktop-portal \
    xdg-desktop-portal-hyprland \
    waybar \
    rofi-wayland \
    kitty \
    nautilus \
    grim \
    slurp \
    wl-clipboard \
    pavucontrol \
    polkit \
    seatd \
    qt5-wayland \
    qt6-wayland \
    noto-fonts \
    noto-fonts-emoji \
    ttf-dejavu

arch-chroot /mnt systemctl enable seatd

# =========================================================
#                     ZSH
# =========================================================

echo "[9/10] Настройка ZSH..."

arch-chroot /mnt chsh -s /bin/zsh "$USERNAME"

# =========================================================
#                     ЗАВЕРШЕНИЕ
# =========================================================

echo "[10/10] Завершение..."

sync
umount -R /mnt

echo
echo "========================================="
echo "         УСТАНОВКА ЗАВЕРШЕНА"
echo "========================================="
echo
echo "Перезагрузите систему и войдите под пользователем $USERNAME"
echo
echo "========================================="