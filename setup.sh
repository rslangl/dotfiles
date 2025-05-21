#!/bin/bash

set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
#IMAGES_DIR="${ROOT_DIR}/runtime/images"
#DISKS_DIR="${ROOT_DIR}/runtime/vm_disks"

declare -A PACKAGES

PACKAGES=(
  [tmux]="tmux"
  [zsh]="zsh"
  [ohmyzsh]=""
  [terminator]=""
  [ripgrep]=""
  [nvim]=""
  [keychain]=""
  [zoxide]=""
)

usage() {
  echo "Usage: $0 [--setup-system | --setup-packages | --check | --install]"
  exit 1
}

setup_system() {
  echo "Setting up system configs"

  USER_HOME="$HOME"

  declare -A XDG_SYSTEM_PATHS
  XDG_SYSTEM_PATHS=(
    [XDG_CONFIG_DIRS]="/etc/xdg"
    [XDG_DATA_DIRS]="/usr/local/share:/usr/share"
  )

  declare -A XDG_USER_PATHS
  XDG_USER_PATHS=(
    [XDG_CONFIG_HOME]="${USER_HOME}/.config"
    [XDG_DATA_HOME]="${USER_HOME}/.local/share"
    [XDG_CACHE_HOME]="${USER_HOME}/.cache"
    [XDG_STATE_HOME]="${USER_HOME}/.local/state"
  )

  # create environment.d directory
  ENV_DIR="${USER_HOME}/.config/environment.d"
  mkdir -p "$ENV_DIR"

  # write the config file with XDG paths
  for xdg_var in "${!XDG_PATHS[@]}"; do
    echo "$xdg_var=${XDG_PATHS[$xdg_var]}" >>"$ENV_DIR/xdg.conf"
  done

  # create directories
  for xdg_path in "${XDG_PATHS[@]}"; do
    mkdir -p "$xdg_path"
  done

  echo "Done!"
}

setup_packages() {
  echo "Installing packages"
}

check() {
  # TODO: XDG_BASE_DIR
  # TODO: list of packages
  echo "Checking system configs and packages"
}

install() {
  echo "Installing dotfiles"
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
  --setup-system)
    if [[ $EUID -ne 0 ]]; then
      echo "Must run as sudo" >&2
      exit 1
    fi
    setup_system
    ;;
  --setup-packages)
    if [[ $EUID -ne 0 ]]; then
      echo "Must run as sudo" >&2
      exit 1
    fi
    setup_packages
    ;;
  --check)
    check
    ;;
  --install)
    install
    ;;
  -h | --help)
    usage
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
  shift
done
