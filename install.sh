#!/bin/bash


# install required packages
sudo apt-get update
sudo apt-get -y install curl libfuse2

# install zsh
if test ! $(which zsh); then
    echo "Installing zsh"
    sudo apt -y install zsh
fi

# install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

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

# various package installation (should probably put this in separate file)
if test ! $(which rg); then
  echo "Installing ripgrep"
  wget https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep_14.0.3-1_amd64.deb
  sudo dpkg -i ripgrep_14.0.3-1_amd64.deb
  rm ripgrep_14.0.3-1_amd64.deb
fi

if test ! $(which dust); then
  echo "Installing dust"
  wget https://github.com/bootandy/dust/releases/download/v0.8.6/du-dust_0.8.6_amd64.deb
  sudo dpkg -i du-dust_0.8.6_amd64.deb
  rm du-dust_0.8.6_amd64.deb
fi

if test ! $(which duf); then
  echo "Installing duf"
  wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb
  sudo dpkg -i duf_0.8.1_linux_amd64.deb
  rm duf_0.8.1_linux_amd64.deb
fi

if test ! $(which bat); then
  echo "Installing bat"
  wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
  sudo dpkg -i bat-musl_0.24.0_amd64.deb
  rm bat-musl_0.24.0_amd64.deb
fi

if test ! $(which fd); then
  echo "Installing fd"
  wget https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-musl_9.0.0_amd64.deb
  sudo dpkg -i fd-musl_9.0.0_amd64.deb
  rm fd-musl_9.0.0_amd64.deb
fi

if test ! $(which vivid); then
  echo "Installing vivid"
  wget https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb
  sudo dpkg -i vivid_0.8.0_amd64.deb
  rm vivid_0.8.0_amd64.deb
fi

# install node (required for copilot in neovim)
if test ! $(which node); then
  sudo apt-get install -y ca-certificates curl gnupg
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpgA
  NODE_MAJOR=20
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_14.x focal main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt-get install -y nodejs
fi

# nvim installation / setup
if test ! $(which nvim); then
    echo "Installing nvim"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    mv nvim.appimage /usr/local/bin/nvim
    chmod +x /usr/local/bin/nvim
fi

# nvchad nvim setup
if [ ! -d $HOME/.config/nvim ]; then
  echo "Installing nvchad"
  git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1
fi

# stow dotfiles
if test ! $(which stow); then
  echo "Installing stow"
  sudo apt-get -y install stow
fi

stow -v -t $HOME git
stow -v -t $HOME zsh
stow -v -t $HOME p10k
stow -v -t $HOME/.config/nvim/lua/custom nvim

chsh -s $(which zsh)
