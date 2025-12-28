#!/bin/bash

set -euo pipefail

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
	glow \
	keychain \
	i3 \
	i3lock \
	zoxide \
	zsh \
	eza

# Install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg && \
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list && \
	sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg && \
	sudo apt update && sudo apt install -y wezterm

# Change login shell to zsh
if [ "$SHELL" != "$(command -v zsh)" ]; then
  sudo chsh -s "$(command -v zsh)"
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
