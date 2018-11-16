#! /bin/bash

# Locale

echo 'Locale'

vim /etc/locale.gen
locale-gen
echo 'LANG=pl_PL.UTF-8' >> /etc/locale.conf
echo 'KEYMAP=pl' >> /etc/vconsole.conf
echo 'FONT=Lat2-Terminus16.psfu.gz' >> /etc/vconsole.conf
echo 'FONT_MAP=8859-2' >> /etc/vconsole.conf

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