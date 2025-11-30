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

#set theme elements
pacman -S --needed beautyline oxygen --noconfirm
plasma-apply-lookandfeel -a org.kde.oxygen.desktop
/usr/lib/plasma-changeicons beautyline
rsync -av /surface/files/HotPinkAnenome.colors /usr/share/color-schemes/
rsync -av /surface/files/HotPinkAnenome.colors /home/ellie/.local/share/color-schemes/
plasma-apply-colorscheme HotPinkAnenome
plasma-apply-cursortheme Oxygen_Magenta
rsync -av /surface/files/arch_pink_background.png /home/ellie/Pictures
plasma-apply-wallpaperimage /home/ellie/Pictures/arch_pink_background.png
