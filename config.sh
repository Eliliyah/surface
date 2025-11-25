#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

#set time
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status
locale-gen
confirm "Did the time set correctly?"

#install system services
pacman -S --needed networkmanager --noconfirm
systemctl enable networkmanager
confirm "Did networkmanager install?"

pacman -S --needed sddm --noconfirm
systemctl enable sddm
confirm "Did sddm install?"

pacman -S --needed lm_sensors --noconfirm
systemctl enable lm_sensors
confirm "Did lmsensors install?"lm_sensors acpid power-profiles-daemon  preload upower

pacman -S --needed acpid --noconfirm
systemctl enable acpid
confirm "Did acpid install?"

pacman -S --needed power-profiles-daemon --noconfirm
systemctl enable power-profiles-daemon
confirm "Did power-profiles-daemon install?"

pacman -S --needed bluez bluez-utils pulseaudio-bluetooth blueman --noconfirm
systemctl enable bluetooth
confirm "Did bluetooth install?"

pacman -S --needed preload --noconfirm
systemctl enable preload
confirm "Did preload install?"

pacman -S --needed upower --noconfirm
systemctl enable upower
confirm "Did upower install?"

#install aura and install asusctl
pacman -S aura
aura -A asusctl
confirm "Did asusctl install?"

for pkg in konsole xterm fish vivaldi iwd plasma plasma-meta discord aura starship vscodium btop dolphin strawberry libreoffice-fresh ttf-daddytime-mono-nerd kde-style-oxygen-qt6; do
  pacman -S --needed --noconfirm "$pkg"
done

confirm "Did everything install?"

#Configure journal
echo "Storage=persistent" >> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#enable late microcode updates
echo 1 > /sys/devices/system/cpu/microcode/reload

#Configure zram
pacman -S zram-generator --noconfirm
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

#Configure sddm
aura -A archlinux-themes-sddm --noconfirm
echo "[Theme]
Current=archlinux-simplyblack">> /etc/sddm.conf
nano /etc/sddm.conf
confirm "All good?"

#Configure initramfs for nvidia
sed -i '7,52 s/^/#/' /etc/mkinitcpio.conf
echo "
COMPRESSION="zstd"
MODULES=(crc32c)
BINARIES=()
FILES=()
HOOKS=(base udev autodetect microcode kms modconf block keyboard keymap consolefont filesystems) " >> /etc/mkinitcpio.conf

#Generate the initramfs
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
mkinitcpio -p linux-surface
confirm "Did the initramfs generate successfully?"
