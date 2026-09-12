# Machine Profile: suwesh-linux-dev

## Environment
* **Platform:** Oracle VM VirtualBox (UEFI Mode Enabled)
* **Base OS:** Arch Linux (x86_64)
* **Hostname:** suwesh-linux-dev
* **Primary User:** suwesh (wheel / sudoers)

## Hardware Allocation
* **CPU:** 4 vCPUs
* **RAM:** 4096 MB (4 GB)
* **Storage:** 80.0 GB Virtual Disk (`/dev/sda`)
* **Graphics Controller:** VMSVGA (16 MB Video RAM)
* **Network:** Intel PRO/1000 MT Desktop (NAT)

## Partition Layout & Filesystem Structure (`/dev/sda`)

| Partition | Mount Point | Size | Partition Type / GUID | Filesystem | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `/dev/sda1` | `/boot` | 1.0 GB | EFI System (`C12A7328-...`) | `FAT32` (`vfat`) | Stores `systemd-boot`, kernel (`vmlinuz-linux`), and initramfs |
| `/dev/sda2` | `/` (root) | ~79.0 GB | Linux Filesystem (`0FC63DAF-...`) | `ext4` | Root filesystem containing base OS, packages, and `/home/suwesh` |

## Installed Core Components
* **Kernel & Firmware:** `linux`, `linux-firmware`
* **Bootloader:** `systemd-boot` (configured with `loader.conf` and `arch.conf`)
* **Networking:** `networkmanager` (enabled via systemd)
* **Text Editor:** `nano`
* **Privilege Escalation:** `sudo` (configured via `/etc/sudoers.d/10-wheel`)