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

# New Terminial Init (placed in .gitignore, custom for each pc)
if [ -f $DOTFILES/startup.sh ]; then
  source $DOTFILES/startup.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
