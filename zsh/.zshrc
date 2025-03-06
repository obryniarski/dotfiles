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
  fzf-tab
)

source $ZSH/oh-my-zsh.sh


export LS_COLORS="$(vivid generate one-dark)"
export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# New Terminial Init (placed in .gitignore, custom for each pc)
if [ -f $DOTFILES/startup.sh ]; then
  source $DOTFILES/startup.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "${key[Up]}" fzf-history-widget
