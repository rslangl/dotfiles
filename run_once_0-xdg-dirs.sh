#!/bin/sh

set -e

echo "Creating /etc/profile.d/xdg_dirs.sh with XDG base dir variables..."

sudo mkdir -p /etc/profile.d
sudo touch /etc/profile.d/xdg_dirs.sh

cat <<EOF | sudo tee /etc/profile.d/xdg_dirs.sh >/dev/null
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export BASH_ENV="$XDG_CONFIG_HOME/bash/.bashrc"
EOF

sudo chmod 644 /etc/profile.d/xdg_dirs.sh

