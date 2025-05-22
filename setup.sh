#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
#IMAGES_DIR="${ROOT_DIR}/runtime/images"
#DISKS_DIR="${ROOT_DIR}/runtime/vm_disks"

USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

declare -A XDG_SYSTEM_PATHS
XDG_SYSTEM_PATHS[XDG_CONFIG_DIRS]="/etc/xdg"
XDG_SYSTEM_PATHS[XDG_DATA_DIRS]="/usr/local/share:/usr/share"

declare -A XDG_USER_PATHS
XDG_USER_PATHS[XDG_CONFIG_HOME]="${USER_HOME}/.config"
XDG_USER_PATHS[XDG_DATA_HOME]="${USER_HOME}/.local/share"
XDG_USER_PATHS[XDG_CACHE_HOME]="${USER_HOME}/.cache"
XDG_USER_PATHS[XDG_STATE_HOME]="${USER_HOME}/.local/state"

# packages not accessible through the system package manager
declare -A EXT_PACKAGES
ext_pkgs_defs=(
  "ohmyzsh":"${USER_HOME}/.config/zsh/ohmyzsh"
  "nvidia":"${USER_HOME}/.config/nvidia/settings"
  "zoxide":""
)

for ext_pkg_entry in "${!ext_pkgs_defs[@]}"; do
  IFS=':' read -r pkg_name pkg_xdg_path <<<"$ext_pkg_entry"
  EXT_PACKAGES["$pkg_name"]="$pkg_xdg_path"
done

declare -A PACKAGES
pkgs_defs=(
  "tmux":"${USER_HOME}/.config/tmux"
  "zsh":"${USER_HOME}/.config/zsh"
  "terminator":"${USER_HOME}/.config/terminator"
  "ripgrep":"${USER_HOME}/.config/ripgrep"
  "jq":""
  "fzf":""
  "wget":"${USER_HOME}/.config/wget"
  "nvim":"${USER_HOME}/.config/nvim"
  "keychain":"${USER_HOME}/.config/keychain"
  "maven":"${USER_HOME}/.config/maven"
  "ansible":"${USER_HOME}/.config/ansible"
  "git":"${USER_HOME}/.config/git"
)
for pkgs_entry in "${pkgs_defs[@]}"; do
  IFS=':' read -r pkg_name pkg_cfg_path <<<"$pkgs_entry"
  PACKAGES["$pkg_name"]="$pkg_cfg_path"
done

usage() {
  echo "Usage: $0 [--setup-system | --setup-packages | --check | --install]"
  exit 1
}

setup_system() {
  echo "Setting up system configs"

  # create environment.d directory
  ENV_DIR="${USER_HOME}/.config/environment.d"
  mkdir -p "$ENV_DIR"

  # backup existing xdg.conf
  if [ -e "$USER_HOME/.config/environment.d/xdg.conf" ]; then
    echo "Backing up existing xdg.conf"
    mv "${USER_HOME}/.config/environment.d/xdg.conf" "${USER_HOME}/.config/environment.d/xdg.conf.bak"
  fi

  # write the config file with XDG paths
  for xdg_var in "${!XDG_USER_PATHS[@]}"; do
    echo "Adding XDG path $xdg_var"
    echo "$xdg_var=${XDG_USER_PATHS[$xdg_var]}" >>"$ENV_DIR/xdg.conf"
  done

  for xdg_sys_var in "${!XDG_SYSTEM_PATHS[@]}"; do
    echo "Adding XDG sys path $xdg_sys_var"
    echo "$xdg_sys_var=${XDG_SYSTEM_PATHS[$xdg_sys_var]}" >>"$ENV_DIR/xdg.conf"
  done

  # create directories
  for xdg_path in "${XDG_USER_PATHS[@]}"; do
    echo "Creating XDG path $xdg_path"
    mkdir -p "$xdg_path"
  done

  echo "Done!"
}

install_packages() {
  local pkg_manager="$1"
  local update_cmd="$2"
  local install_cmd="$3"

  echo "Using package manager $pkg_manager"

  echo "Creating XDG paths for packages"
  for pkg in "${!PACKAGES[@]}"; do
    xdg_pkg_path="${PACKAGES[$pkg]}"
    if [[ ! -z "$xdg_pkg_path" ]]; then
      echo "Creating path $xdg_pkg_path"
      mkdir -p "$xdg_pkg_path"
    fi
  done

  echo "Updating cache"
  eval "$update_cmd"

  echo "Installing packages"
  eval "$install_cmd ${!PACKAGES[@]}"

  echo "Done"
}

setup_packages() {
  echo "Setting up packages"

  if command -v apt &>/dev/null; then
    install_packages "apt" "apt update" "apt install -y"
  elif command -v zypper &>/dev/null; then
    install_packages "zypper" "zypper refresh" "zypper install -y"
  else
    echo "Package manager not found or not supported"
    exit 1
  fi
}

check() {
  echo "Checking system configs and packages"

  XDG_VARS=("${!XDG_SYSTEM_PATHS[@]}" "${!XDG_USER_PATHS[@]}")

  for xdg_var in "${XDG_VARS[@]}"; do
    if [[ -z "$xdg_var" ]]; then
      echo "XDG variable not set: $xdg_var"
    fi
  done

  missing_pkgs=()

  for pkg in "${PACKAGES[@]}"; do
    if command -v "$pkg" >/dev/null 2>&1; then
      missing_pkgs+=("$pkg")
      echo "Package not found: $pkg"
    fi
  done
}

install() {
  echo "Installing dotfiles"
  # TODO: use stow?
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
  --setup-system)
    if [[ "$EUID" -ne 0 ]]; then
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
