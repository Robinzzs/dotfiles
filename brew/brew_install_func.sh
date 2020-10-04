#!/bin/bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

function _brew_check() {
  # Check OS
  if [[ $OSTYPE != darwin* ]]; then
    echo "${RED}Error: only install software via brew_cask on macOS.${NORMAL}" >&2
    exit 1
  fi

  # Check brew
  if ! command -v brew >/dev/null 2>&1; then
    printf "${GREEN} ➜  Installing Homebrew and Cask...${NORMAL}\n"

    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # brew tap caskroom/cask
    # brew tap caskroom/fonts
    # brew tap buo/cask-upgrade

    brew tap adoptopenjdk/openjdk
    brew tap d12frosted/emacs-plus
    brew tap homebrew/cask
    brew tap homebrew/cask-drivers
    brew tap homebrew/cask-fonts
    brew tap homebrew/core
    brew tap homebrew/services
    brew tap railwaycat/emacsmacport
    brew tap twlz0ne/ccls

  fi
}

function _brew_install_pkg() {
  pkgs=$1
  for pkg in ${pkgs[*]}; do
    printf "${GREEN} ➜  Installing %s...${NORMAL}\n" "${pkg}"
    brew install "${pkg}"
  done
}

function _brew_install_app() {
  apps=$1
  for app in ${apps[*]}; do
    printf "${GREEN} ➜  Installing %s...${NORMAL}\n" "${app}"
    brew cask install "${app}"
  done
}

function _brew_cleanup() {
  printf "${GREEN} ➜  Cleanup cache files...${NORMAL}\n"
  brew cleanup
}

# function main {
#     check
#     install
#     cleanup
# }

# main
