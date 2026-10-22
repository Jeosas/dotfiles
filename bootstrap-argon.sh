#!/usr/bin/env bash

ROOT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

set -euxo pipefail

timedatectl set-ntp true

# Setup partitions
parted --script --align optimal /dev/sda -- \
  mktable gpt \
  mkpart boot 0% 512MiB \
  type 1 C12A7328-F81F-11D2-BA4B-00A0C93EC93B \
  set 1 esp on \
  mkpart root 512MiB 100% \
  type 2 CA7D7CCB-63ED-4C53-861C-1742536059CC \
  print

# Format
mkfs.vfat -n boot /dev/sda1
mkfs.btrfs /dev/sda2

# Create subvolumes
mount -t btrfs /dev/sda2 -o compress-force=zstd,noatime,ssd /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@vartmp
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots
umount /mnt

# Mounting everything
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/{boot,home,var/log,var/cache,var/tmp,tmp,.snapshots}
mount /dev/sda1 /mnt/boot
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@home /dev/sda2 /mnt/home
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@log /dev/sda2 /mnt/var/log
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@cache /dev/sda2 /mnt/var/cache
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@vartmp /dev/sda2 /mnt/var/tmp
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@tmp /dev/sda2 /mnt/tmp
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@snapshots /dev/sda2 /mnt/.snapshots

# Bootstrap system

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >>/mnt/etc/fstab

source "$ROOT_DIR/common.sh" argon
