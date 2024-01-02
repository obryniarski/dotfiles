# shared aliases are defined here, any machine specific aliases should be defined in
# $DOTFILES/custom_aliases.zsh

alias vzrc="vim ~/.zshrc"
alias szrc="source ~/.zshrc"
alias la="ls --group-directories-first -agh"
alias gl="git log --oneline --decorate --all"
alias vim="nvim"
alias cdot="cd $DOTFILES"
alias ha="eza -al --group-directories-first -s extension -I '*~'"
alias has="ha --total-size -s size -r"
