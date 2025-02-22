# dotfiles

## Overview

My dotfiles for feeling special.

## Requirements

Either use bootstrap, or manually install everything in accordance with the following section, which assumes a minimal Debian 12 install.

**Dependencies available through APT**
```shell
sudo apt update
sudo apt install -y \
  i3 \
  terminator \
  tmux \
  rofi \
  zsh \
  keychain
```

**Polybar**: It's just purdy.
```shell
mkdir -p $HOME/dev/co/
cd $HOME/dev/co/
git clone https://github.com/polybar/polybar && cd polybar
./build.sh --all-features
cd build/ && sudo make install
```

**i3lock**: It's also purdy.
```shell
TODO
```

**Oh-my-zsh**: Guess what, purdy, and functional.
```shell
TODO
```

**zoxide**: Requires fewer neural pathways to find your stuff.
```shell
TODO
```

## Usage

Specify the desired path for the dotfiles directory:
```shell
mkdir $HOME/infra
cd $HOME/infra
git clone https://github.com/rslangl/dotfiles
```

Invoke dotbot:
```shell
./install.sh
```
