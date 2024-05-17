#!/bin/bash
# vim: set ft=sh:

h_have() { 
  type "$1" > /dev/null 2>&1;
}

date >&2
env >&2

xrdb -merge "$HOME/.Xresources"

xset r rate 500 30

setxkbmap \
  -layout us,ru \
  -option ctrl:nocaps,ctrl:swap_lwin_lctl,ctrl:swap_rwin_rctl,grp:shifts_toggle,terminate:ctrl_alt_bksp

if h_have xbindkeys; then
  xbindkeys -n &
fi

[ ! -f "$HOME/.xsession.local" ] || . "$HOME/.xsession.local"
