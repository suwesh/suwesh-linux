#!/usr/bin/env bash
set -euo pipefail

TARGET_HOSTNAME="suwesh-linux-dev"
TARGET_USER="suwesh"
TIMEZONE="Asia/Kolkata"

echo "==> Setting Timezone to ${TIMEZONE}..."
ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
hwclock --systohc

echo "==> Configuring Localization..."
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "==> Configuring Hostname and Network Mapping..."
echo "${TARGET_HOSTNAME}" > /etc/hostname
cat < /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   \({TARGET_HOSTNAME}.localdomain\){TARGET_HOSTNAME}
HOSTSEOF

echo "==> Configuring User Accounts and Sudo Access..."
if ! id -u "${TARGET_USER}" >/dev/null 2>&1; then
    useradd -m -G wheel -s /bin/bash "${TARGET_USER}"
fi

echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10-wheel
chmod 440 /etc/sudoers.d/10-wheel

echo "==> Enabling NetworkManager Service..."
systemctl enable NetworkManager

echo "==> Installing systemd-boot Bootloader..."
bootctl install

cat < /boot/loader/loader.conf
default arch.conf
timeout 3
console-mode max
editor no
LOADEREOF

ROOT_UUID=$(blkid -s PARTUUID -o value /dev/sda2)

cat < /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=${ROOT_UUID} rw
ENTRYEOF

echo "==> Phase 2 Chroot System Configuration Complete!"