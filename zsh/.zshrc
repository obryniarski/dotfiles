# Path to your dotfiles
export DOTFILES="$HOME/.dotfiles"

# set up powershell prompting
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM=$DOTFILES
plugins=(
	git
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LS_COLORS="$(vivid generate one-dark)"

# New Terminial Init
cd ~/workspace
source .venv/default-env/bin/activate

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/p10k/.p10k.zsh.
[[ ! -f ~/.dotfiles/p10k/.p10k.zsh ]] || source ~/.dotfiles/p10k/.p10k.zsh
