# Environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias vim='nvim'

export HISTSIZE=268435456
export SAVEHIST="$HISTSIZE"
export HISTFILE="$$ZDOTDIR/.zsh_history"

# Set prompt
autoload -U colors && colors
PS1='%F{blue}>%f '
setopt autocd
setopt interactive_comments
setopt INC_APPEND_HISTORY

pk() {
  pgrep -i "$1" | sudo xargs kill -p
}
