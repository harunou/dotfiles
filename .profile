# ~/.profile
# vim:set et sw=2:

PATH=$HOME/.local/bin:/usr/local/bin:${PATH}
NVM_DIR=$HOME/.nvm
if [ -d "$NVM_DIR" ]; then
  default=$(<$NVM_DIR/alias/default)
  if [[ $default =~ "lts" ]]; then
    default=$(<$NVM_DIR/alias/$default)
  fi

  PATH=$NVM_DIR/versions/node/v${default#v}/bin:${PATH}
  export NVM_DIR
fi
ENV=$HOME/.profile
export PATH ENV

if [ -z "$PAGER" ] && type less >/dev/null 2>&1; then
  PAGER=less
  export PAGER
fi
LESS="FXRq#10"

if [ -z "$VISUAL" ]; then
  type vim >/dev/null 2>&1 && VISUAL=vim || VISUAL=vi
fi
EDITOR=$VISUAL
export LESS EDITOR VISUAL

if [ ! -f "$HOME/. harunou" ]; then
  harunou setup
fi

if [ -f "$HOME/.local/share/fonts/terminus-console/ter-c20n.psf.gz" ]; then
  export FBFONT=$HOME/.local/share/fonts/terminus-console/ter-c16n.psf.gz
fi


