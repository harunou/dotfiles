# ~/.profile
# vim:set et sw=2:

PATH=$HOME/.local/bin:/usr/local/bin:${PATH}
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

