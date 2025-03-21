#!/usr/bin/env bash
###########################
# Written by: Ron Negrov 
# Date: 21/03
# Purpose: Check if all required tools are installed
# Version: 0.0.1
. /etc/os-release
###########################

packages=(python3 python3-pip pipx pipenv makeself sqlite3 virtualbox)

install_missing_packages() {
  for package in "${packages[@]}"; do
    if ! command -v "$package" &> /dev/null && ! dpkg -l | grep -q "$package"; then
      echo "Installing missing package: $package"
      $1 install -y "$package"
    fi
  done
  echo "Finshed installing packages"
}

case "$ID" in
  debian|ubuntu)
    install_missing_packages "sudo apt"
    ;;

  centos|rhel|fedora)
    install_missing_packages "sudo yum"
    ;;

  arch)
    install_missing_packages "sudo pacman -S --noconfirm"
    ;;

  *)
    echo "Unsupported OS: $ID"
    exit 1
    ;;
esac
