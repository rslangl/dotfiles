#!/bin/sh

set -euo pipefail

# Set required value path for ZDOTDIR
sudo touch /etc/environment.d/zsh.conf
sudo cat <<EOF | sudo tee /etc/environment.d/zsh.conf >/dev/null
ZDOTDIR=$HOME/.config/zsh
EOF

# Install required packages
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
	eza \
	bat

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
mkdir -p "${XDG_CACHE_HOME:-${HOME/.local/share}}"/tig

# Change default terminal emulator to wezterm
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which wezterm) 50
sudo update-alternatives --set x-terminal-emulator $(which wezterm)

# Change default window manager to i3
# TODO

# Set custom user directories
DEV="$HOME"/dev
DEV_CO="$DEV"/co  # checkout other projects
DEV_RE="$DEV"/re  # reverse engineering
DEV_SW="$DEV"/sw  # main software projects
MAILS="$HOME"/mail
VM="$HOME"/vm
DOCS_ART="$HOME"/docs/art
DOCS_TECH="$HOME"/docs/tech
DOCS_SCI="$HOME"/docs/sci
DOCS_LANG="$HOME"/docs/lang
SHARE_CAST="$HOME"/share/cast   # podcasts
SHARE_SEED="$HOME"/share/seed   # torrents
SHARE_LECT="$HOME"/share/lect   # lectures

ensure_dir() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

ensure_dir "$DEV"
ensure_dir "$DEV_CO"
ensure_dir "$DEV_RE"
ensure_dir "$DEV_SW"
ensure_dir "$MAILS"
ensure_dir "$VM"
ensure_dir "$DOCS_ART"
ensure_dir "$DOCS_TECH"
ensure_dir "$DOCS_SCI"
ensure_dir "$DOCS_LANG"
ensure_dir "$SHARE_CAST"
ensure_dir "$SHARE_SEED"
ensure_dir "$SHARE_LECT"

# Cleanup
sudo apt autoremove -y
