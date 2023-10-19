#!/bin/bash
# multilib and pacs
mv /etc/pacman.conf /etc/pacman.conf.old
echo "pacman.conf -> pacman.conf.old"
cp pacman.conf /etc/pacman.conf
pacman -Sy
pacman -S git grub os-prober efibootmgr base-devel firefox steam xorg xorg-xinit vim neovim iwd dhcpcd pulseaudio pavucontrol ly openresolv toilet
echo "username:"
read username
useradd -m $username
passwd $username
echo "$username ALL=(ALL:ALL) ALL"
systemctl enable iwd
systemctl enable ly
systemctl enable dhcpcd
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo "обзови устроиство:"
read hostname1
echo $hostname1 >> /etc/hostname
mkdir /home/$username/git
git clone https://github.com/es1s/dwmmycfg /home/$username/git/dwm
git clone https://aur.archlinux.org/paru.git /home/$username/git/paru
echo "дальше установка ручками в dwm (make clean install), paru (makepkg -si) в твоём домашнем каталоге"
echo "exec dwm" >> /home/$username/.xinitrc
echo "настройка xorg на русич"
localectl --no-convert set-x11-keymap us,ru pc105 dvorak grp:alt_shift_toggle
chown $username:$username /home/$username/*
echo "диск на котором будет grub"
read disk
cp grub /etc/default/grub
grub-install --efi-directory=/boot --boot-directory=/boot --bootloader-id=grub /dev/$disk
grub-mkconfig -o /boot/grub/grub.cfg
echo "Не добро пожаловать в ARCH"
toilet "arch"
