# Zsh configuration

ANTIGEN=$HOME/.antigen
DOTFILES=$HOME/dotfiles

# Configure Antigen
declare -a ANTIGEN_CHECK_FILES
ANTIGEN_CHECK_FILES=($HOME/.zshrc $HOME/.zshrc.local)

# Load Antigen
if [[ $OSTYPE == darwin* ]]; then
  source /usr/local/share/antigen/antigen.zsh
fi

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle colored-man-pages
antigen bundle common-aliases
antigen bundle cp
antigen bundle extract
antigen bundle fancy-ctrl-z
antigen bundle git
antigen bundle gitfast
antigen bundle sudo
antigen bundle z

# antigen bundle svn

# Misc bundles.
command -v python >/dev/null 2>&1 && antigen bundle djui/alias-tips
command -v fdfind >/dev/null 2>&1 && alias fd='fdfind'

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
  antigen bundle osx
  if command -v brew >/dev/null 2>&1; then
    alias bu='brew update && brew upgrade'
    alias bcu='brew cu --all --yes --cleanup'
    alias bua='bu && bcu'
  fi
fi

# Load FD
command -v fd >/dev/null 2>&1 && antigen bundle fd

# Load FZF
if command -v fzf >/dev/null 2>&1; then
  if [[ $OSTYPE == cygwin* ]]; then
    [ -f /etc/profile.d/fzf.zsh ] && source /etc/profile.d/fzf.zsh
  else
    antigen bundle fzf
    antigen bundle andrewferrier/fzf-z
    export FZFZ_PREVIEW_COMMAND='tree -NC -L 2 -x --noreport --dirsfirst {}'
  fi

  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --hidden --files || find ."
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
  export FZF_ALT_C_OPTS="--preview 'tree -NC {} | head -200'"
fi

antigen bundle hlissner/zsh-autopair
# antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zdharma/fast-syntax-highlighting
# antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme ys # ys, dst, steeef, wedisagree, robbyrussell
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Local customizations, e.g. theme, plugins, aliases, etc.
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# Tell Antigen that you're done
antigen apply

# Completion enhancements
source $DOTFILES/shell/completion.zsh

# Aliases
#

# Unalias the original fd in oh-my-zsh
alias fd >/dev/null && unalias fd

# # General
# alias zshconf="$EDITOR $HOME/.zshrc; $EDITOR $HOME/.zshrc.local"
# alias h='history'
# alias c='clear'
# alias ip="curl -i http://ip.taobao.com/service/getIpInfo.php\?ip\=myip"

# alias gtr='git tag -d $(git tag) && git fetch --tags' # Refresh local tags from remote

command -v bat >/dev/null 2>&1 && alias cat='bat'
command -v htop >/dev/null 2>&1 && alias top='htop'

if [[ $OSTYPE == darwin* ]]; then
  command -v gls >/dev/null 2>&1 && alias ls='gls --color=tty --group-directories-first'
fi

# # Emacs
# alias me="emacs -Q -l ~/.emacs.d/init-mini.el" # mini emacs
# alias mte="emacs -Q -nw -l ~/.emacs.d/init-mini.el" # mini terminal emacs
# alias e="$EDITOR -n"
# alias ec="$EDITOR -n -c"
# alias ef="$EDITOR -c"
# alias te="$EDITOR -a '' -nw"
# alias rte="$EDITOR -e '(let ((last-nonmenu-event nil) (kill-emacs-query-functions nil)) (save-buffers-kill-emacs t))' && te"

# # Upgrade
# alias upgrade_repo='git pull --rebase --stat origin master'
# alias upgrade_dotfiles='cd $DOTFILES && upgrade_repo; cd - >/dev/null'
# alias upgrade_emacs='emacs -Q --batch -L "$HOME/.emacs.d/lisp/" -l "init-funcs.el" -l "init-package.el" --eval "(update-config-and-packages t)"'
# alias upgrade_oh_my_tmux='cd $HOME/.tmux && upgrade_repo; cd - >/dev/null'
# alias upgrade_env='upgrade_dotfiles; sh $DOTFILES/install.sh; upgrade_oh_my_tmux; upgrade_oh_my_zsh'

# alias upgrade_cargo='cargo install-update -a' # cargo install cargo-update
# alias upgrade_gem='gem update && gem cleanup'
# alias upgrade_go='GO111MODULE=on && $DOTFILES/install_go.sh'
# alias upgrade_npm='for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2); do npm -g install "$package"; done'
# alias upgrade_pip="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
# alias upgrade_pip3="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"

if [[ $OSTYPE == darwin* ]]; then
  command -v brew >/dev/null 2>&1 && alias upgrade_antigen='brew upgrade antigen'
  alias upgrade_brew_cask='$DOTFILES/install_brew_cask.sh'
fi

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
