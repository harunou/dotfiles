# ~/.profile
# vim: ft=sh sw=2

h_have() { 
  type "$1" > /dev/null 2>&1 ;
}

h_has_substring() { 
  test "${1#*$2}" != "$1" >/dev/null 2>&1 ;
}


PATH=$HOME/.local/bin:/usr/local/bin:${PATH}
ENV=$HOME/.profile
export PATH ENV

NVM_DIR=$HOME/.config/nvm
if [ -d "$NVM_DIR" ]; then
  default=$(<$NVM_DIR/alias/default)
  if [[ $default =~ "lts" ]]; then
    default=$(<$NVM_DIR/alias/$default)
  fi

  if [[ $default =~ ^[0-9]+$ ]]; then
    latest_version=$(find "$NVM_DIR/versions/node" -maxdepth 1 -type d -name "v${default}.*" | sort -V | tail -n 1)
    default=$(basename "$latest_version")
  fi

  PATH="$NVM_DIR/versions/node/$default/bin:${PATH}"
  export NVM_DIR
fi

if [ -z "$PAGER" ] && h_have less; then
  PAGER=less
  export PAGER
fi
LESS="FXRq#10"

if [ -z "$VISUAL" ]; then
  h_have vim && VISUAL=vim || VISUAL=vi
fi
EDITOR=$VISUAL
export LESS EDITOR VISUAL

if [ -f "$HOME/.local/share/fonts/terminus-console/ter-c20n.psf.gz" ]; then
  export FBFONT=$HOME/.local/share/fonts/terminus-console/ter-c16n.psf.gz
fi

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
GPG_TTY=$(tty)
export GPG_TTY

XDG_DATA_HOME=$HOME/.local/share
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_DIRS=/usr/local/share/:/usr/share/
XDG_CONFIG_DIRS=/etc/xdg
XDG_CACHE_HOME=$HOME/.cache

export XDG_DATA_HOME XDG_CONFIG_HOME XDG_DATA_DIRS XDG_CONFIG_DIRS \
  XDG_CACHE_HOME

if [ ! -f "$HOME/. harunou" ]; then
  harunou setup
fi
