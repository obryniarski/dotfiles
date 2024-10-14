#!/bin/bash

read -s -p "Enter password for echo sudo: " sudoPW

# install required packages
echo $sudoPW | sudo -S apt-get update
echo $sudoPW | sudo -S apt-get -y install curl libfuse2

# install zsh
if test ! $(which zsh); then
    echo "Installing zsh"
    echo $sudoPW | sudo -S apt -y install zsh
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

  echo $sudoPW | sudo -S mkdir /usr/share/fonts/MesloLGS
  echo $sudoPW | sudo -S mv *.ttf /usr/share/fonts/MesloLGS
  fc-cache -f -v
  rm -rf *Meslo*
fi

# various package installation (should probably put this in separate file)
if test ! $(which rg); then
  echo "Installing ripgrep"
  wget https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep_14.0.3-1_amd64.deb
  echo $sudoPW | sudo -S dpkg -i ripgrep_14.0.3-1_amd64.deb
  rm ripgrep_14.0.3-1_amd64.deb
fi

if test ! $(which dust); then
  echo "Installing dust"
  wget https://github.com/bootandy/dust/releases/download/v0.8.6/du-dust_0.8.6_amd64.deb
  echo $sudoPW | sudo -S dpkg -i du-dust_0.8.6_amd64.deb
  rm du-dust_0.8.6_amd64.deb
fi

if test ! $(which duf); then
  echo "Installing duf"
  wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb
  echo $sudoPW | sudo -S dpkg -i duf_0.8.1_linux_amd64.deb
  rm duf_0.8.1_linux_amd64.deb
fi

if test ! $(which bat); then
  echo "Installing bat"
  wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
  echo $sudoPW | sudo -S dpkg -i bat-musl_0.24.0_amd64.deb
  rm bat-musl_0.24.0_amd64.deb
fi

if test ! $(which fd); then
  echo "Installing fd"
  wget https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-musl_9.0.0_amd64.deb
  echo $sudoPW | sudo -S dpkg -i fd-musl_9.0.0_amd64.deb
  rm fd-musl_9.0.0_amd64.deb
fi

if test ! $(which delta); then
  echo "Installing delta"
  wget https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
  echo $sudoPW | sudo -S dpkg -i git-delta_0.16.5_amd64.deb
  rm git-delta_0.16.5_amd64.deb
fi

if test ! $(which vivid); then
  echo "Installing vivid"
  wget https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb
  echo $sudoPW | sudo -S dpkg -i vivid_0.8.0_amd64.deb
  rm vivid_0.8.0_amd64.deb
fi

if test ! $(which eza) && test $(which cargo); then
  echo "Installing eza"
  cargo install eza
fi

if test ! $(which atuin); then
  echo "Installing atuin"
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

if test ! $(which fzf); then
  echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  source $HOME/.fzf/install
fi

if test ! $(which lazygit); then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  echo $sudoPW | sudo -S install lazygit /usr/local/bin
  rm lazygit
  rm lazygit.tar.gz
fi

# install node (required for copilot in neovim)
if test ! $(which node); then
  echo $sudoPW | sudo -S apt-get install -y ca-certificates gnupg
  echo $sudoPW | sudo -S mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  echo $sudoPW | sudo -S apt-get update
  echo $sudoPW | sudo -S apt-get install -y nodejs
fi

# nvim installation / setup
if test ! $(which nvim); then
    echo "Installing nvim"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    echo $sudoPW | sudo -S mv nvim.appimage /usr/local/bin/nvim
    chmod +x /usr/local/bin/nvim
fi

# nvchad nvim setup
if [ ! -d $HOME/.config/nvim ]; then
  echo "Installing nvchad"
  git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1
  mkdir $HOME/.config/nvim/lua/custom
fi

if test ! $(which stow); then
  echo "Installing stow"
  echo $sudoPW | sudo -S apt-get -y install stow
fi

# clear/backup existing dotfiles
mv $HOME/.gitconfig $HOME/.gitconfig.old
mv $HOME/.zshrc $HOME/.zshrc.old
mv $HOME/.p10k.zsh $HOME/.p10k.zsh.old
rm -rf $HOME/.config/nvim/lua/custom/*

# stow dotfiles
stow -v -t $HOME git
stow -v -t $HOME zsh
stow -v -t $HOME p10k
stow -v -t $HOME/.config/nvim/lua/custom nvim
stow -v -t $HOME tmux
stow -v -t $HOME/.config/kitty kitty

chsh -s $(which zsh)
