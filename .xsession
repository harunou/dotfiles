#!/bin/sh
# vim:set et sw=2:

date >&2
env >&2

xrdb -merge "$HOME/.Xresources"

xset r rate 500 30
xset +fp $HOME/.local/share/fonts/terminus-x11
xset fp rehash

setxkbmap \
  -layout us,ru \
  -option ctrl:nocaps,ctrl:swap_lwin_lctl,ctrl:swap_rwin_rctl,grp:shifts_toggle,terminate:ctrl_alt_bksp

xsetroot -solid '#008080'

[ ! -f "$HOME/.xsession.local" ] || . "$HOME/.xsession.local"

: >"$HOME/.env.$DISPLAY"
chmod 0600 "$HOME/.env.$DISPLAY"
for var in DISPLAY XAUTHORITY DESKTOP_SESSION \
  XDG_SEAT XDG_SEAT_PATH XDG_SESSION_TYPE XDG_SESSION_CLASS \
  XDG_SESSION_ID XDG_VTNR XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP \
  XDG_CONFIG_DIRS XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_GREETER_DATA_DIR \
  MANDATORY_PATH DEFAULTS_PATH DBUS_SESSION_BUS_ADDRESS SSH_AGENT_PID \
  SSH_AUTH_SOCK GNOME_KEYRING_PID; do
  eval val=\$$var
  if [ -n "$val" ]; then
    echo "$var='$val'" >> "$HOME/.env.$DISPLAY"
    exports="$exports $var"
    if [ "$DISPLAY" = ":0" ]; then
      tmux setenv -g $var "$val" 2>/dev/null
    fi
  fi
done
[ -z "$exports" ] || echo "export$exports" >> "$HOME/.env.$DISPLAY"


type xmonad >/dev/null 2>&1 && xmonad &
wmpid=$!

sleep 0.5

type dex >/dev/null 2>&1 && dex -a

wait $wmpid

