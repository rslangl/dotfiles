#!/bin/sh

set -e

sudo touch /etc/environment.d/zsh.conf
sudo cat <<EOF | sudo tee /etc/environment.d/zsh.conf >/dev/null
ZDOTDIR=$HOME/.config/zsh
EOF

