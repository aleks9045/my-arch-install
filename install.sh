#!/bin/bash

set -eu

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
BOOT_PART="${DISK}p5"     # EFI раздел Arch
WIN_EFI_PART="${DISK}p1"  # EFI Windows
ROOT_PART="${DISK}p6"     # /
HOME_PART="${DISK}p7"     # /home (не форматируется)

# Система
HOSTNAME="arch-vivo"
USERNAME="aleks"

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
echo "EFI раздел Arch: $BOOT_PART"
echo "EFI раздел Windows: $WIN_EFI_PART"
echo "Root раздел: $ROOT_PART"
echo "Home раздел: $HOME_PART"
echo
echo "БУДЕТ ОТФОРМАТИРОВАН:"
echo "  - $ROOT_PART"
echo
echo "НЕ БУДУТ ТРОНУТЫ:"
echo "  - $HOME_PART"
echo "  - $BOOT_PART"
echo "========================================="

read -r -p "Продолжить? (y/N): " REPLY < /dev/tty

case "$REPLY" in
    [Yy]) ;;
    *)
        echo "Установка отменена."
        exit 1
        ;;
esac

# =========================================================
#                     ПРОВЕРКА РАЗДЕЛОВ
# =========================================================

for part in "$BOOT_PART" "$WIN_EFI_PART" "$ROOT_PART" "$HOME_PART"; do
    if [[ ! -b "$part" ]]; then
        echo "Раздел не найден: $part"
        exit 1
    fi
done

# =========================================================
#                     ФОРМАТИРОВАНИЕ
# =========================================================

echo "[1/7] Форматирование root..."

mkfs.ext4 -F "$ROOT_PART" -L ARCH_ROOT

# =========================================================
#                     МОНТИРОВАНИЕ
# =========================================================

echo "[2/7] Монтирование..."

mount "$ROOT_PART" /mnt

mkdir -p /mnt/{boot,home,efi}

mount "$BOOT_PART" /mnt/boot
mount "$HOME_PART" /mnt/home
mount "$WIN_EFI_PART" /mnt/efi

# =========================================================
#                     УСТАНОВКА СИСТЕМЫ
# =========================================================

echo "[3/7] Установка базовой системы..."

pacstrap -K /mnt \
    base \
    linux \
    linux-firmware \
    intel-ucode \
    sudo \
    vim \
    networkmanager \
    iwd \
    grub \
    efibootmgr \
    os-prober

# =========================================================
#                     FSTAB
# =========================================================

echo "[4/7] Генерация fstab..."

genfstab -U /mnt > /mnt/etc/fstab

# =========================================================
#                     НАСТРОЙКА
# =========================================================

echo "[5/7] Настройка системы..."

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
# Пароли
# ---------------------------------------------------------

echo "root:$ROOT_PASSWORD" | chpasswd

# ---------------------------------------------------------
# Пользователь
# ---------------------------------------------------------

useradd \
    -G wheel \
    -s /bin/bash \
    $USERNAME

echo "$USERNAME:$USER_PASSWORD" | chpasswd

# ---------------------------------------------------------
# Права на home
# ---------------------------------------------------------

chown $USERNAME:$USERNAME /home/$USERNAME

# ---------------------------------------------------------
# sudo
# ---------------------------------------------------------

echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

# ---------------------------------------------------------
# Сервисы
# ---------------------------------------------------------

systemctl enable NetworkManager
systemctl enable iwd

EOF

# =========================================================
#                     GRUB
# =========================================================

echo "[6/7] Установка GRUB..."

arch-chroot /mnt grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot \
    --bootloader-id=GRUB \
    --recheck

arch-chroot /mnt /bin/bash -c "
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
"

# =========================================================
#                     ЗАВЕРШЕНИЕ
# =========================================================

echo "[7/7] Завершение..."

sync
umount -R /mnt

echo
echo "========================================="
echo "         УСТАНОВКА ЗАВЕРШЕНА"
echo "========================================="
echo
echo "Перезагрузитесь:"
echo "reboot"
echo
echo "В UEFI выберите:"
echo "GRUB"
echo
echo "========================================="