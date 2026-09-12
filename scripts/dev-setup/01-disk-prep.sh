#!/usr/bin/env bash
set -euo pipefail

TARGET_DISK="/dev/sda"

echo "==> Wiping disk signature on ${TARGET_DISK}..."
wipefs -a "${TARGET_DISK}"

echo "==> Partitioning ${TARGET_DISK} (1G EFI, Remaining Root)..."
sfdisk "${TARGET_DISK}" <<'EOF'
label: gpt
size=1G, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

echo "==> Formatting partitions..."
mkfs.fat -F 32 "${TARGET_DISK}1"
mkfs.ext4 -F "${TARGET_DISK}2"

echo "==> Mounting filesystems..."
mount "${TARGET_DISK}2" /mnt
mount --mkdir "${TARGET_DISK}1" /mnt/boot

echo "==> Bootstrapping base packages..."
pacstrap -K /mnt base linux linux-firmware nano networkmanager sudo

echo "==> Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "==> Disk prep and base installation complete!"
