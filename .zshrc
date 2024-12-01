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
zstyle ':omz:update' mode reminder # just remind me to update when it's time

# ==================================
# PLUGINS
# ==================================
if [[ $TERM_PROGRAM != 'vscode' && $TERM_PROGRAM != 'WarpTerminal' ]]; then
  # ZSH_TMUX_AUTOSTART=true
fi
if [[ $TERM_PROGRAM == "WarpTerminal" ]]; then
  SPACESHIP_PROMPT_ASYNC=FALSE
fi
ZSH_TMUX_AUTOQUIT=false
GIT_AUTO_FETCH_INTERVAL=120
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  # ssh-agent
  tmux
  git-auto-fetch
)
# eval `keychain --eval id_rsa quick_rsa`
source $ZSH/oh-my-zsh.sh
# export TERM=screen-256color

# ==================================
# Exports
# ==================================
PATH="$HOME/.local/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
remove_volta() {
  export PATH="$(echo $PATH | sed "s#$VOLTA_HOME/bin##g")"
}
export VOLTA_FEATURE_PNPM=1

export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# moon
export PATH="$HOME/.moon/bin:$PATH"
# proto
export PROTO_HOME="$HOME/.proto"
# export PATH="$PROTO_HOME/bin:$PATH"
# export PATH="$PROTO_HOME/shims:$PATH"

export DEVBOX_NO_PROMPT=1
proto_shims() {
  PROTO_PATH="$PROTO_HOME/shims:$PROTO_HOME/bin"
  if [[ -z "$(echo $PATH | grep $PROTO_PATH)" ]]; then
    export PATH="$PROTO_PATH:$PATH"
    echo "Added shims"
  else
    export PATH="$(echo $PATH | sed "s#$PROTO_PATH##g")"
    echo "Removed shims"
  fi
}

if [[ -z "$(echo $XDG_SESSION_TYPE | grep tty)" ]]; then
  export EDITOR="code --wait"
  export VISUAL="code --wait"
else
  export EDITOR=nvim
  export VISUAL=nvim
fi

export PATH="$PATH:/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin"

# ==================================
# Evals
# ==================================
MISE="$HOME/.local/bin/mise"
if [[ -e $MISE ]]; then
  eval "$($MISE activate -s zsh)"
fi

if [[ -e "$(which pyenv)" ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

eval "$(starship init zsh)"

# ==================================
# Aliases
# ==================================
alias lzd=lazydocker
alias vim=nvim
alias explorer=/mnt/c/Windows/explorer.exe
alias cls=clear
alias doco="docker compose"
alias dockerps="docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}\""
alias k=kubectl
alias f="$(pay-respects zsh)"
alias qans=/$HOME/Documents/Quick/ansible/dev

if [[ -e "$(which exa)" ]]; then
  alias ls="exa --group-directories-first --time-style=long-iso --color=auto --icons"
else
  alias ls="ls -FXAvhc --group-directories-first --time-style=+'%y/%m/%d %H:%M' --color=auto"
fi

if [[ -e "$(which zoxide)" ]]; then
  eval "$(zoxide init zsh)"
  alias cd=z
fi

if [[ -e "$(which bat)" ]]; then
  alias cat="bat"
fi

alias p=pnpm
alias px="pnpm dlx"
alias pe="pnpm exec"

# alias my_ip="ip -4 -o addr show eth0 | awk '{print \$4}' | grep -oP '(\d+\.){3}\d+'"
# ==================================
# Functions
# ==================================
ssh_tunnel() {
  if ([[ -z $2 ]]); then
    PORT=5432
  else
    PORT=$2
  fi
  ssh -N -L ":${PORT}:localhost:${PORT}" -o ServerAliveInterval=60 $1
}

ans() {
  pushd ~/.ansible >/dev/null
  $@
  popd >/dev/null
}

v() {
  if [[ -d $1 ]]; then
    pushd $1 >/dev/null
    nvim
    popd >/dev/null
  else
    nvim "$@"
  fi
}

rvim() {
  dir=$2
  dir="${dir%/}" # strip trailing slash (if any)
  subdir="${dir##*/}"

  dest="$HOME/.rmounts/${subdir}"
  mkdir -p $dest 1>/dev/null
  sshfs $1:$2 $dest
  pushd $dest 1>/dev/null
  nvim
  popd 1>/dev/null
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
  dir="${dir%/}" # strip trailing slash (if any)
  subdir="${dir##*/}"

  dest="$HOME/.rmounts/${subdir}"
  mkdir -p $dest 1>/dev/null
  rclone --vfs-cache-mode full mount $1:$2 $dest &
  mount=$!
  while [[ -s $dest ]]; do
    sleep 0.1
    echo -n .
  done
  pushd $dest 1>/dev/null
  nvim
  popd 1>/dev/null
  kill -INT $mount
  fuser -v $dest
  while [[ ! -s $dest ]]; do
    sleep 0.1
    echo -n .
  done
  rm -d $dest
}

if [[ -e "$(which dagger)" ]]; then
  source <(dagger completion zsh)
fi
if [[ -e "$(which pnpm)" ]]; then
  source <(pnpm completion zsh) 2>/dev/null
fi
if [[ -e "$(which k3d)" ]]; then
  source <(k3d completion zsh)
fi
if [[ -e "$(which moon)" ]]; then
  source <(moon completions)
fi
if [[ -e "$(which volta)" ]]; then
  source <(volta completions zsh)
fi
