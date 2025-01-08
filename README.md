# dotfiles

## Overview

My dotfiles for feeling special

## Requirements

Based on a fresh Debian 12 install, some packages are required:
```shell
sudo apt update
sudo apt install -y \
  i3
  terminator
  tmux
  rofi
  zsh
  keychain
```

Some other packages need (?) to be built from source, e.g. polybar:
```shell
mkdir -p $HOME/dev/co/
cd $HOME/dev/co/
git clone https://github.com/polybar/polybar && cd polybar
./build.sh --all-features
cd build/ && sudo make install
```

A custom i3 lock screen is also used:
```shell
TODO
```

Oh-my-zsh is used with zsh:
```shell
TODO
```

TODO:
* zoxide
* ohmyzsh plugins

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
