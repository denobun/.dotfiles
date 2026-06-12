systemctl enable NetworkManager
systemctl start NetworkManager

pacman -Syu kitty fish noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ttf-jetbrains-mono
pacman -Syu git sudo fastfetch openssh docker docker-compose bun rustup stow cloc cava btop cmatrix asciiquarium
rustup default stable

pacman -Syu firefox chromium obsidian telegram-desktop obs-studio kdenlive
pacman -Syu hyprland hyprpaper mako wofi yazi waybar flameshot grim playerctl xdg-desktop-portal-hyprland xdg-desktop-portal hyprpolkitagent

# для звука (надо проверить, мб что-то лишнее)
sudo pacman -S pipewire wireplumber pipewire-alsa pipewire-audio alsa-card-profiles 

mkdir /mnt/hdd

useradd -mG wheel admin
passwd admin

export EDITOR=nvim

# Расскоментировать в visudo
%wheel ALL(ALL:ALL) ALL

sudo timedatectl set-timezone Europe/Moscow

chsh -s /usr/bin/fish

# Выход и вход под админа
exit
start-hyprland



sudo systemctl enable docker
sudo systemctl start docker

# Примениться при перезаходе юзера
sudo usermod -aG docker "$USER" 

git config --global user.name "dev"
git config --global user.email "dev@dev.com"
git config --global init.defaultBranch main

ssh-keygen -t ed25519 -C "arch" -f ~/.ssh/git

# Ввести ключ на гитхабе 
cat ~/.ssh/git.pub

~/.ssh/config:
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/git

ssh -T git@github.com


git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~ && rm -rf paru

paru -Syu throne-bin vscodium-bin portproton

раскоментировать multilib в pacman.conf



/etc/locale.gen раскомментировать en_US.UTF-8 UTF-8 через sudo 
echo “LANG=en_US.UTF-8” | sudo tee /etc/locale.conf 

sudo locale-gen



# надо отключать кэш в браузере - а то HMR наебнется (но желательно только для dev сайта, чтобы тот же ютуб лучше работал)

# Склонировать дотфайлы
И stow .

mkdir ~/projects