#!/bin/bash
read -s -p "Enter password for sudo: " sudoPW
echo

set -e

# Update and install required packages
echo "$sudoPW" | sudo -S apt-get update
echo "$sudoPW" | sudo -S apt-get -y install lbzip2 libfuse2 build-essential curl wget tree stow zsh tmux fontconfig

# install recommended powershell10k font
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


# Install Rust (cargo) if not installed
if ! command -v cargo &> /dev/null; then
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Install Go if not installed
if ! command -v go &> /dev/null; then
  echo "Installing go"
  curl -OL https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
  echo "$sudoPW" | sudo -S rm -rf /usr/local/go
  echo "$sudoPW" | sudo -S tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
  echo "$sudoPW" | sudo -S rm -rf go1.23.2.linux-amd64.tar.gz
fi

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install uv if not installed
if ! command -v uv &> /dev/null; then
  echo "Installing uv"
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install ripgrep if not installed
if ! command -v rg &> /dev/null; then
  echo "Installing ripgrep"
  wget https://github.com/BurntSushi/ripgrep/releases/download/14.0.3/ripgrep_14.0.3-1_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i ripgrep_14.0.3-1_amd64.deb
  rm ripgrep_14.0.3-1_amd64.deb
fi

# Install dust if not installed
if ! command -v dust &> /dev/null; then
  echo "Installing dust"
  wget https://github.com/bootandy/dust/releases/download/v0.8.6/du-dust_0.8.6_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i du-dust_0.8.6_amd64.deb
  rm du-dust_0.8.6_amd64.deb
fi

# Install duf if not installed
if ! command -v duf &> /dev/null; then
  echo "Installing duf"
  wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i duf_0.8.1_linux_amd64.deb
  rm duf_0.8.1_linux_amd64.deb
fi

# Install bat if not installed
if ! command -v bat &> /dev/null; then
  echo "Installing bat"
  wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i bat-musl_0.24.0_amd64.deb
  rm bat-musl_0.24.0_amd64.deb
fi

# Install fd if not installed
if ! command -v fd &> /dev/null; then
  echo "Installing fd"
  wget https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-musl_9.0.0_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i fd-musl_9.0.0_amd64.deb
  rm fd-musl_9.0.0_amd64.deb
fi

# Install difftastic if not installed
if ! command -v difft &> /dev/null; then
  echo "Installing difftastic"
  wget https://github.com/Wilfred/difftastic/releases/download/0.62.0/difft-x86_64-unknown-linux-gnu.tar.gz
  tar -xf difft-x86_64-unknown-linux-gnu.tar.gz
  echo "$sudoPW" | sudo -S mv difft /usr/local/bin
  rm difft-x86_64-unknown-linux-gnu.tar.gz
fi

# Install vivid if not installed
if ! command -v vivid &> /dev/null; then
  echo "Installing vivid"
  wget https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb
  echo "$sudoPW" | sudo -S dpkg -i vivid_0.8.0_amd64.deb
  rm vivid_0.8.0_amd64.deb
fi

# Install eza if not installed and cargo exists
if ! command -v eza &> /dev/null; then
  echo "Installing eza"
  cargo install eza
fi

# Install fzf if not installed and not already cloned
if ! command -v fzf &> /dev/null && [ ! -d "$HOME/.fzf" ]; then
  echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all
  export PATH="$HOME/.fzf/bin:$PATH"
fi

# Install btop if not installed
if ! command -v btop &> /dev/null; then
  echo "Installing btop"
  wget https://github.com/aristocratos/btop/releases/download/v1.4.0/btop-x86_64-linux-musl.tbz
  tar -xf btop-x86_64-linux-musl.tbz
  cd btop
  echo "$sudoPW" | sudo -S make install
  cd ..
  rm btop-x86_64-linux-musl.tbz
  rm -rf btop
fi

# Install lazygit if not installed
if ! command -v lazygit &> /dev/null; then
  echo "Installing lazygit"
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  echo "$sudoPW" | sudo -S install lazygit /usr/local/bin
  rm lazygit lazygit.tar.gz
fi

# Install / Upgrade Node.js 
echo "Installing node"
echo "$sudoPW" | sudo -S apt-get install -y ca-certificates gnupg
echo "$sudoPW" | sudo -S mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "$sudoPW" | sudo -S apt-get update
echo "$sudoPW" | sudo -S apt-get install -y nodejs


if ! command -v yarn &> /dev/null; then
  echo "Installing yarn"
  echo "$sudoPW" | sudo -S npm install -g yarn
fi


# Install nvim if not installed
if ! command -v nvim &> /dev/null; then
  echo "Installing nvim"
  wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
  tar -xf nvim-linux-x86_64.tar.gz
  echo "$sudoPW" | sudo -S cp -R nvim-linux-x86_64/bin/* /usr/local/bin/
  echo "$sudoPW" | sudo -S cp -R nvim-linux-x86_64/share/nvim /usr/local/share/
  rm -rf nvim-linux-x86_64.tar.gz nvim-linux-x86_64
fi

# Install nvchad if nvim config not present
if [ ! -d "$HOME/.config/nvim" ]; then
  echo "Installing nvchad"
  git clone https://github.com/NvChad/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/lua/chadrc.lua"
  rm -rf "$HOME/.config/nvim/lua/mappings.lua"
  rm -rf "$HOME/.config/nvim/lua/plugins/init.lua"
  rm -rf "$HOME/.config/nvim/lua/configs/conform.lua"
  rm -rf "$HOME/.config/nvim/lua/configs/lspconfig.lua"
  echo "require 'myinit'" >> "$HOME/.config/nvim/init.lua"
fi

# Install tmux plugin manager if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install stylua if not installed (and cargo is available)
if ! command -v stylua &> /dev/null && command -v cargo &> /dev/null; then
  echo "Installing stylua formatter"
  cargo install stylua
fi

# Backup existing dotfiles
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.old"
[ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.old"
[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.old"
[ -f "$HOME/.config/kitty/kitty.conf" ] && mv "$HOME/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf.old"
[ -f "$HOME/.config/tmux-powerline" ] && mv "$HOME/.config/tmux-powerline" "$HOME/.config/tmux-powerline.old"
[ -d "$HOME/.config/nvim/lua/custom" ] && rm -rf "$HOME/.config/nvim/lua/custom"/*

# Stow dotfiles
stow -v -t "$HOME" git
stow -v -t "$HOME" zsh
stow -v -t "$HOME" p10k
stow -v -t "$HOME/.config/nvim/lua" nvim
stow -v -t "$HOME" tmux
source "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
stow -v -t "$HOME/.config/kitty" kitty
stow -v -t "$HOME/.config/tmux-powerline" tmux-powerline

# Change default shell to zsh
echo "$USER"
sudo usermod --shell "$(command -v zsh)" "$USER"
