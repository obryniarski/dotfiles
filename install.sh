#!/bin/bash

# install zsh
if test ! $(which zsh); then
    echo "Installing zsh"
    sudo apt install zsh
fi
chsh -s $(which zsh)

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# powershell10k setup
#
# check if MesloLGS NF is installed
if [ ! -d /usr/share/fonts/MesloLGS ]; then
  echo "Installing MesloLGS NF font (recommended for use with powerlevel10k)"
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

  mkdir /usr/share/fonts/MesloLGS
  mv *.ttf /usr/share/fonts/MesloLGS
  fc-cache -f -v
  rm -rf *Meslo*
fi

# various package installation (should probably put this in separate folder)
if test ! $(which rg); then
  echo "Installing ripgrep"
  sudo apt-get -y install ripgrep
fi

if test ! $(which vivid); then
  echo "Installing vivid"
  wget "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
  sudo dpkg -i vivid_0.8.0_amd64.deb
  rm vivid_0.8.0_amd64.deb
fi

# nvim installation / setup
if test ! $(which nvim); then
    echo "Installing nvim"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    mv nvim.appimage /usr/local/bin/nvim
    chmod +x /usr/local/bin/nvim
fi

# nvchad nvim setup
if [ ! -d ~/.config/nvim ]; then
  echo "Installing nvchad"
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi



# stow dotfiles



# NOTE TO SELF: NEOVIM USES ~/.config/nvim/init.vim INSTEAD OF .vimrc, SO STOW TO HERE INSTEAD
