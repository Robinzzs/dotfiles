#!/bin/bash

source ./brew_install_func.sh

develop_pkgs=(
  adns     # C/C++ resolver library and DNS resolver utilities
  aom      # Codec library for encoding and decoding AV1 video streams
  apr      # Apache Portable Runtime library
  apr-util # Companion library to apr, the Apache Portable Runtime library
  aspell   # Spell checker with better logic than ispell
  autoconf # Automatic configure script builder
  # autojump     # Shell extension to jump to frequently used directories
  cairo        # Vector graphics library with cross-device output support
  ccls         # C/C++/ObjC language server
  clang-format # Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript
  cmake        # Cross-platform make
  coreutils    # GNU File, Shell, and Text utilities
  ctags        # Ctags generates an index (or tag) file of language objects found in source files that allows these items to be quickly and easily located by a text editor or other utility.
  direnv       # Load/unload environment variables based on $PWD
  editorconfig # Maintain consistent coding style between multiple editors
  emacs-plus   # editor
  fd           # Simple, fast and user-friendly alternative to find
  ffmpeg       # Play, record, convert, and stream audio and video
  fftw         # C routines to compute the Discrete Fourier Transform
  flac         # Free lossless audio codec
  fontconfig   # XML-based font configuration API for X Windows
  freetype     # Software library to render fonts
  frei0r       # Minimalistic plugin API for video effects
  fribidi      # Implementation of the Unicode BiDi algorithm
  gcc          # GNU compiler collection
  gd           # Graphics library to dynamically manipulate images
  gdbm         # GNU database manager
  gdk-pixbuf   # Toolkit for image loading and pixel buffer manipulation
  gettext      # GNU internationalization (i18n) and localization (l10n) library
  ghostscript  # Interpreter for PostScript and PDF
  giflib       # Library and utilities for processing GIFs
  git          # Distributed revision control system
  glances      # Alternative to top/htop
  glib         # Core application library for C
  glslang      # OpenGL and OpenGL ES reference compiler for shading languages
  gmp          # GNU multiple precision arithmetic library
  gnu-sed
  gnu-tar
  gnupg
  gnutls
  graphite2
  grep
  hadolint
  barfbuzz
  hub
  hwloc
  icu4c
  ilmbase
  imagemagick
  imagemagick@6
  imlib2
  isl
  jasper
  jpeg
  lame
  leptonica
  libassuan
  libbluray
  libcaca
  libcroco
  libde265
  libevent
  libffi
  libgcrypt
  libgpg-error
  libheif
  libidn2
  libksba
  libmpc
  libogg
  libomp
  libpng
  librsvg
  libsamplerate
  libsndfile
  libsoxr
  libtasn1
  libtiff
  libtool
  libunistring
  libusb
  libvidstab
  libvorbis
  libvpx
  libvterm
  little-cms2
  llvm
  lua
  lua@5.1
  luarocks
  lz4
  lzo
  make
  markdown
  metis
  mpfr
  mplayer
  ncurses
  netpbm
  nettle
  node
  npth
  open-mpi
  openblas
  opencore-amr
  openexr
  openjpeg
  openssl@1.1
  opus
  p11-kit
  pango
  pcre
  perl
  pinentry
  pixman
  pkg-config
  plplot
  python
  python@3.8
  qt
  readline
  ripgrep
  rtmpdump
  rubberband
  scrcpy
  sdl2
  shared-mime-info
  shellcheck
  snappy
  speex
  sqlite
  srt
  subversion
  suite-sparse
  swig
  tbb
  tesseract
  texinfo
  the_silver_searcher
  theora
  unbound
  utf8proc
  watchman
  webp
  wget
  wordnet
  x264
  x265
  xpdf
  xvid
  xz
  zsh
)

develop_apps=(
  cheatsheet # Tool to list all active shortcuts of the current application
  # little-snitch
  qqmusic # Chinese music streaming application
  typora  # Configurable document editor that supports Markdown
  dotnet-sdk
  mactex
  qt-creator
  visual-studio-code
  electron
  microsoft-edge
  skim
  wechat
  iina
  miniconda
  sogouinput
  xquartz
  iterm2
  mos
  sublime-text
  youdaodict
  julia
  qq
  # texmacs
  zoom
)

_brew_install_pkg "${develop_pkgs[*]}"
_brew_install_app "${develop_apps[*]}"

# [ ! -z $failed_items ] && echo The following items were failed to install: && echo $failed_items
