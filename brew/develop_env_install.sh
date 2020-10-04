#!/bin/bash

source ./brew_install_func.sh

develop_pkgs=(
  adns     # C/C++ resolver library and DNS resolver utilities
  aom      # Codec library for encoding and decoding AV1 video streams
  apr      # Apache Portable Runtime library
  apr-util # Companion library to apr, the Apache Portable Runtime library
  aspell   # Spell checker with better logic than ispell
  autoconf # Automatic configure script builder
  # autojump        # Shell extension to jump to frequently used directories
  cairo        # Vector graphics library with cross-device output support
  ccls         # C/C++/ObjC language server
  clang-format # Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript
  cmake
  coreutils
  ctags
  direnv
  editorconfig
  emacs-plus
  fd
  ffmpeg
  fftw
  flac
  fontconfig

  git
  svn
)

apps=(
  texlive
)

_brew_install_pkg "${develop_pkgs[*]}"
# install_app
