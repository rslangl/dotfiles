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

# TODO: install zoxide

# Install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg && \
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list && \
	sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg && \
	sudo apt update && sudo apt install -y wezterm

# Change login shell
sudo chsh -s $(which zsh) "$USER"

# Create required directories
mkdir -p "${XDG_STATE_HOME:-${HOME/.local/state}}"/zsh
mkdir -p "${XDG_CACHE_HOME:-${HOME/.local/share}}"/zsh

# Change default terminal emulator to wezterm
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/wezterm

# Change default window manager to i3
# TODO


