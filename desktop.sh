#!/bin/bash
# multilib and pacs
mv /etc/pacman.conf /etc/pacman.conf.old
echo "pacman.conf -> pacman.conf.old"
cp pacman.conf /etc/pacman.conf
pacman -Sy
pacman -S git dmenu grub os-prober efibootmgr base-devel firefox steam xorg xorg-xinit vim neovim dhcpcd pulseaudio pavucontrol ly openresolv toilet
echo "username:"
read username
useradd -m $username
passwd $username
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers
systemctl enable ly
systemctl enable dhcpcd
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "hostname:"
read hostname1
echo $hostname1 >> /etc/hostname
mkdir /home/$username/git
git clone https://github.com/es1s/dwmmycfg /home/$username/git/dwm
git clone https://aur.archlinux.org/paru.git /home/$username/git/paru
echo "handle install dwm (make clean install), paru (makepkg -si) in homedir"
echo "exec dwm" >> /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
chown $username:$username /home/$username/*
chown $username:$username /home/$username/git/paru
chown $username:$username /home/$username/git/dwm
echo "disk for grub"
read disk
cp grub /etc/default/grub
grub-install --efi-directory=/boot --boot-directory=/boot --bootloader-id=grub /dev/$disk
grub-mkconfig -o /boot/grub/grub.cfg
echo "Welcome to ARCH"
toilet "arch"
