
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/juanod/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# bindkey '^H' backward-kill-word
# bindkey '5~' kill-word

export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# ==================================
# PLUGINS
# ==================================
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  ssh-agent
  tmux
)
source $ZSH/oh-my-zsh.sh
# export TERM=screen-256color

# ==================================
# Exports
# ==================================
PATH="$HOME/.local/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

# ==================================
# Evals
# ==================================
eval "$(/home/juanod/.local/share/rtx/bin/rtx activate -s bash)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval "$(starship init zsh)"

# ==================================
# Aliases
# ==================================
alias lzd=lazydocker
alias vim=nvim

# ==================================
# Functions
# ==================================
fvim() {
  pushd $1 > /dev/null
  nvim
  popd > /dev/null
}

v() {
  if [[ -d $1 ]]; then
    pushd $1 > /dev/null
    nvim
    popd > /dev/null
  else
    nvim "$@"
  fi
}

rvim() {
  dir=$2
  dir="${dir%/}"             # strip trailing slash (if any)
  subdir="${dir##*/}"

  dest="$HOME/.rmounts/${subdir}"
  mkdir -p $dest 1> /dev/null
  sshfs $1:$2 $dest
  pushd $dest 1> /dev/null
  nvim
  popd 1> /dev/null
  fuser -kfs -TERM $dest
  fuser -v $dest
  fusermount -u $dest >/dev/null 2>&1
  unmounted=$?
  while [[ unmounted -ne 0 ]]; do
    sleep 0.1
    echo -n .
    fusermount -u $dest >/dev/null 2>&1
    unmounted=$?
  done
  rm -d $dest
}

rv() {
  dir=$2
  dir="${dir%/}"             # strip trailing slash (if any)
  subdir="${dir##*/}"

  dest="$HOME/.rmounts/${subdir}"
  mkdir -p $dest 1> /dev/null
  rclone --vfs-cache-mode full mount $1:$2 $dest &
  mount=$!
  while [[ -s $dest ]]; do
    sleep 0.1
    echo -n .
  done
  pushd $dest 1> /dev/null
  nvim
  popd 1> /dev/null
  kill -INT $mount
  fuser -v $dest
  while [[ ! -s $dest ]]; do
    sleep 0.1
    echo -n .
  done
  rm -d $dest
}

p() {
  pnpm "$@"
}

px() {
  pnpm dlx "$@"
}

pe() {
  pnpm exec "$@"
}

