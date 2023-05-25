#!/bin/sh

echo -n "Provide your username\n"
read username

echo -n "Provide your working directory name\n"
read work_dir

echo -n "Provide your github username\n"
read git_user


sudo apt install -y fzf git make build-essential neovim lua5.4 openssh-server curl zsh cowsay wget flameshot  libxft-dev libxinerama-dev libxrandr-dev  libharfbuzz-dev neofetch picom fonts-hermit feh alsa-utils gcc g++ libfreetype6-dev libglib2.0-dev libcairo2-dev fonts-font-awesome ffmpeg playerctl ranger mpv xclip scrot imagemagick software-properties-common

sudo apt update && sudo apt upgrade 

flatpak install spotify slack

cowsay "Installing oh-my-zh and powerlevel10k"

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo mkdir /usr/share/fonts/meslo && sudo mv *.ttf /usr/share/fonts/meslo/

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir ~/.local/share/fonts
unzip Hack.zip -d HackTTF && mv HackTTF ~/.local/share/fonts/

cd $HOME
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cowsay "Setting up neovim"

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neoviudo apt-get install neovim

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

git clone git@github.com:$git_user/nvim.git /home/$username/.config/nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	 ~/.local/share/nvim/site/pack/packer/start/packer.neovim

rm $HOME/.zshrc
rm $HOME/.xinitr
cp $HOME/$work_dir/suckless/conf/dwm.desktop $HOME/
ln -s $HOME/$work_dir/suckless/conf/.xinitrc $HOME/
ln -s $HOME/$work_dir/suckless/.zshrc $HOME/
ln -s $HOME/$work_dir/dotfiles/.tmux.conf $HOME/


cd $HOME/$work_dir/suckless/dwm && sudo make clean install
cd $HOME/$work_dir/suckless/slstatus && sudo make clean install
cd $HOME/$work_dir/suckless/st && sudo make clean install
cd $HOME/$work_dir/suckless/dmenu && sudo make clean install
cd $HOME/$work_dir/suckless/slock && sudo make clean install

cowsay "Restart the shell and do:\ 
nvm install node\
source ~/.bashrc\
cd ~/.config/nvim && nvm use node\
to complete neovim installation"
