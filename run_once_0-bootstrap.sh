#!/bin/sh

set -euo pipefail

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
        xorg \
	i3 \
	i3lock \
        dmenu \
        nitrogen \
        picom \
	zoxide \
	zsh \
	eza \
	bat \
        fd-find \
        weechat

# Set XDG dirs for zsh
sudo cp -f /etc/zsh/zshenv /etc/zsh/zshenv.bak

sudo tee /tmp/zshenv.tmp >/dev/null <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

sudo cmp -s /tmp/zhsenv.tmp /etc/zsh/zshenv || \
  sudo install -m 0644 /tmp/zshenv.tmp /etc/zsh/zshenv

rm /tmp/zshenv.tmp

ZOXIDE_VERSION=0.9.8
curl -fsSL "https://github.com/ajeetdsouza/zoxide/releases/download/v${ZOXIDE_VERSION}/zoxide_${ZOXIDE_VERSION}-1_amd64.deb" -o zoxide.deb && \
	sudo dpkg -i zoxide.deb && \
	rm zoxide.deb

# Install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg && \
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list && \
	sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg && \
	sudo apt update && sudo apt install -y wezterm

# Change login shell
sudo chsh -s $(which zsh) "$USER"

# Create required directories
mkdir -p "${XDG_STATE_HOME:-${HOME/.local/state}}"/zsh
mkdir -p "${XDG_CACHE_HOME:-${HOME/.cache}}"/zsh
mkdir -p "${XDG_CACHE_HOME:-${HOME/.cache}}"/tig
mkdir -p "${XDG_CONFIG_HOME:-${HOME/.config}}"/git
mkdir -p "${XDG_DATA_HOME:-${HOME/.local/share}}"/wallpapers

# Change default terminal emulator to wezterm
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which wezterm) 50
sudo update-alternatives --set x-terminal-emulator $(which wezterm)

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

# Compile nvim
NVIM_VERSION=0.11
pushd "$HOME"/dev/co/neovim
git checkout release-"$NVIM_VERSION"
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
popd

# Cleanup
sudo apt autoremove -y
