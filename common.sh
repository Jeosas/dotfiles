#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "error: missing host_name"
fi

HOSTNAME="$1"

set -euxo pipefail

# Base

pacman -Syu

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

sed -e '/en_US.UTF-8/s/^#*//g' -i /etc/locale.gen
sed -e '/fr_FR.UTF-8/s/^#*//g' -i /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=us" >/etc/vconsole.conf
echo "$HOSTNAME" >/etc/hostname

# Network

pacman --noconfirm -Sy networkmanager
systemctl enable --now NetworkManager.service

# Grub install

pacman --noconfirm -Sy grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# Recreate initramfs

sed -i "s/fsck//" /etc/mkinitcpio.conf
mkinitcpio -P

# Create jeosas user

useradd -m -G users,wheel -s /bin/bash jeosas

echo "## Creating user jeosas password"
passwd jeosas

# Setup sudo

cat "%wheel ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

passwd -d root
passwd --lock root

# Install care package

pacman --noconfirm -Sy pipewire git vim
pacman --noconfirm -Sy sway polkit ghostty
cat <<EOF >/home/jeosas/.bash_profile
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec sway
fi
EOF
