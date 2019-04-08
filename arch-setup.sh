#! /bin/bash

# Misc configurations

echo 'Misc configurations'

loadkeys pl
timedatectl set-ntp true

# File system creation

echo 'Setting disk partitions'

cfdisk /dev/sda
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4


# Creating SWAP

echo 'Creating SWAP'
mkswap /dev/sda2
swapon /dev/sda2

# Mounting

echo 'Mount'
mount /dev/sda3 /mnt

## Boot

mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

## Home

mkdir /mnt/home
mount /dev/sda4 /mnt/home

# Pacstrap

echo 'System installation'
pacstrap /mnt base base-devel vim networkmanager yay

# Fstab

echo 'Gen fstab'
genfstab -U /mnt >> /mnt/etc/fstab

# Root change

echo 'Mounting into new installation'

arch-chroot /mnt

#! /bin/bash

# Locale

echo 'Locale'

vim /etc/locale.gen
echo 'LANG=pl_PL.UTF-8' >> /etc/locale.conf
echo 'KEYMAP=pl' >> /etc/vconsole.conf
echo 'FONT=Lat2-Terminus16.psfu.gz' >> /etc/vconsole.conf
echo 'FONT_MAP=8859-2' >> /etc/vconsole.conf
locale-gen

# Network configuration

echo 'Network configuration'

echo 'anonymoous' >> /etc/hostname
echo '127.0.1.1	anonymous.localdomain anonymous' >> /etc/hosts
systemctl enable NetworkManager

# Root password

echo 'Password set'
passwd

# GRUB

echo 'GRUB setup'
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#Reboot

reboot