#!/bin/sh

cowsay "Installing needed packages..."
sleep 1
sudo pacman -S i3 dmenu feh imagemagick scrot xorg-xrandr playerctl redshift alsa-utils picom xclip alsa-utils dunst blueman ranger mpv ffmpegthumbnailer ffmpeg w3m

cowsay "Installing needed fonts..."
sleep 1
yay -S ttf-font-awesome
cd ~/Downloads/
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir ~/.local/share/fonts
unzip Hack.zip -d HackTTF && mv HackTTF ~/.local/share/fonts/

cowsay "Setting up redshift"
sleep 1
mkdir -p ~/.config/systemd/user/
cp ~/projects/dotfiles/geoclue-agent.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable geoclue-agent.service
systemctl --user start geoclue-agent.service

cowsay "Copying i3 directory to ~/.config..."
sleep 1
cd ~/projects/dotfiles/
cowsay "Creating proper symlinks for urxvt, tmux, i3 and zsh"
sleep 1

mkdir  $HOME/.config/i3/
mkdir  $HOME/.config/dunst/
ln -s $HOME/projects/dotfiles/i3/config $HOME/.config/i3/
ln -s $HOME/projects/dotfiles/ranger $HOME/.config/
ln -s $HOME/projects/dotfiles/.Xresources $HOME/
ln -s $HOME/projects/dotfiles/.zshrc $HOME/
ln -s $HOME/projects/dotfiles/.tmux.conf $HOME/
ln -s $HOME/projects/dotfiles/i3/dunstrc $HOME/.config/dunst/

cowsay "Done :D"

