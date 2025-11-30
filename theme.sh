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
mkdir /usr/share/color-schemes/
rsync -av /surface/files/HotPinkAnemone.colors /usr/share/color-schemes/
mkdir /home/ellie/.local/share/color-schemes/
rsync -av /surface/files/HotPinkAnemone.colors /home/ellie/.local/share/color-schemes/
rsync -av /surface/files/arch_pink_background.png /home/ellie/Pictures
plasma-apply-wallpaperimage /home/ellie/Pictures/arch_pink_background.png
