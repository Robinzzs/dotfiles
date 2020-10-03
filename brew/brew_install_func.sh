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

function brew_check() {
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

function brew_install_pkg() {
  for pkg in $@; do
    printf "${GREEN} ➜  Installing ${pkg}...${NORMAL}\n"
    # brew install ${pkg}
  done
}

function brew_install_app() {
  for app in ${apps[@]}; do
    printf "${GREEN} ➜  Installing ${app}...${NORMAL}\n"
    brew cask install ${app}
  done
}

function brew_cleanup() {
  printf "${GREEN} ➜  Cleanup cache files...${NORMAL}\n"
  brew cleanup
}

# function main {
#     check
#     install
#     cleanup
# }

# main
