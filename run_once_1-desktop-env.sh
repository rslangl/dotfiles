#!/bin/bash

sudo apt install -y \
	dnf \
	ripgrep \
	curl \ 
	wget \
	gnupg \
	make \
	cmake \
	tmux \
	rlwrap \ 
	fzf \
	jq \
	fd \
	glow \
	keychain \
	wezterm \
	i3 \
	i3lock \
	zoxide \
	zsh

# Change login shell to zsh
if [ "$SHELL" != "$(command -v zsh)" ]; then
  chsh -s "$(command -v zsh)"
fi

# Use XDG dirs for completion and history files
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME"/zsh/history
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

# Change default terminal emulator to wezterm
# TODO

# Change default window manager to i3
# TODO

# Aliases
# TODO: ls -> eza, cat -> bat
