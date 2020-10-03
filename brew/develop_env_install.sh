#!/bin/bash

source ./brew_install_func.sh

pkgs=(
  git
  svn
)

apps=(
  texlive
)

brew_install_pkg ${pkgs[@]}
# install_app
