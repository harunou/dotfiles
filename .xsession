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

[ ! -f "$HOME/.xsession.local" ] || . "$HOME/.xsession.local"

# case "$@" in
#   *xmonad-session*)
#     ;;
#   *gnome-session*|*xfce*)
#     exec "$@"
#     ;;
# esac

# for wm in $wm xmonad; do
#   if type $wm >/dev/null 2>&1; then
#     set -- $wm
#     break
#   fi
# done

# xsetroot -solid '#008080'

# "$@" &
# wmpid=$!

# : ${XDG_CURRENT_DESKTOP:=${XDG_SESSION_DESKTOP:-${GDMSESSION:-Old}}}

# sleep 0.5

# # Note(harunou): autostart
# if h_have dex; then
#   dex -a -e "$XDG_CURRENT_DESKTOP"
# elif h_have xbindkeys; then
#   xbindkeys -n &
# fi

# wait $wmpid
