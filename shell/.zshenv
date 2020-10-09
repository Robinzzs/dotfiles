# ZSH envioronment

export LANG="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export EDITOR='emacsclient -a "emacs"'
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH

# Homebrew
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottle

# FZF
export PATH=$HOME/.fzf/bin:$PATH

# ncurses
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"

#libffi
export LDFLAGS="-L/usr/local/opt/libffi/lib"

#imagemagick@6
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"

# #LLVM OpenMP
# export PATH="/usr/local/opt/llvm/bin:$PATH"
# # export C_INCLUDE_PATH=/usr/local/opt/llvm/include:/usr/local/opt/libomp/include:$C_INCLUDE_PATH
# # export CPLUS_INCLUDE_PATH=/usr/local/opt/llvm/include:/usr/local/opt/libomp/include:$CPLUS_INCLUDE_PAT
# # export LIBRARY_PATH=/usr/local/opt/llvm/include:/usr/local/opt/libomp/include:$LIBRARY_PATH
# # export LD_LIBRARY_PATH=/usr/local/opt/llvm/include:/usr/local/opt/libomp/includex:$LD_LIBRARY_PATH
# # LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
# # export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
# # export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/opt/llvm/lib/
# export LIBRARY_PATH="/usr/local/lib"
# export LDFLAGS="-L/usr/local/opt/libomp/lib"
# export CPPFLAGS="-I/usr/local/opt/libomp/include"

# open-mpi
export PATH="/usr/local/opt/open-mpi/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/opt/open-mpi/lib:$LD_LIBRARY_PATH"
export LDFLAGS="-L/usr/local/opt/open-mpi/lib"
export CPPFLAGS="-I/usr/local/opt/open-mpi/include"

# fftw
export LD_LIBRARY_PATH="/usr/local/opt/fftw/lib:$LD_LIBRARY_PATH"
export PATH="/usr/local/opt/fftw/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/opt/fftw/lib:$LD_LIBRARY_PATH"
export LDFLAGS="-L/usr/local/opt/fftw/lib"
export CPPFLAGS="-I/usr/local/opt/fftw/include"

# lapcak
export LDFLAGS="-L/usr/local/opt/lapack/lib"
export CPPFLAGS="-I/usr/local/opt/lapack/include"
export PKG_CONFIG_PATH="/usr/local/opt/lapack/lib/pkgconfig"

# openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# libffi
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

# # netpbm (ppm)
# export PATH="/usr/local/opt/netpbm/bin:$PATH"
# export LD_LIBRARY_PATH="/usr/local/opt/netpbm/lib:$LD_LIBRARY_PATH"
# export LDFLAGS="-L/usr/local/opt/netpbm/lib"
# export CPPFLAGS="-I/usr/local/opt/netpbm/include"

#madagascar
source /Users/robinzzs/madagascar/share/madagascar/etc/env.sh
# export RSFPOOT=$HOME/Madagascar
export DATAPATH=~/DATAFILE/
# export PYTHONPATH="/Users/robinzzs/madagascar/lib/python3.7/site-packages/rsf"

# openblas
export LDFLAGS="-L/usr/local/opt/openblas/lib"
export CPPFLAGS="-I/usr/local/opt/openblas/include"

# doom emacs
export PATH="/Users/robinzzs/.emacs.d/bin:$PATH"

# Add Visual Studio Code (code)
# export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# matlab
export PATH="$PATH:/Applications/Polyspace/R2019b/bin"

# qt
export PATH="/usr/local/opt/qt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/qt/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# cargo texlab
export PATH="/Users/robinzzs/.cargo/bin:$PATH"

# # miniconda3
# # export PATH="/Users/robinzzs/miniconda3/bin:$PATH"
# export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
