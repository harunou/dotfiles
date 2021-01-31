#!/bin/bash
# vim:set et sw=2:

date >&2
env >&2

xrdb -merge "$HOME/.Xresources"

xset r rate 500 30
xset +fp $HOME/.local/share/fonts/terminus-x11
xset fp rehash
xset s off
xset -dpms

setxkbmap \
  -layout us,ru \
  -option ctrl:nocaps,ctrl:swap_lwin_lctl,grp:shifts_toggle,terminate:ctrl_alt_bksp

[ ! -f "$HOME/.xsession.local" ] || . "$HOME/.xsession.local"

: >"$HOME/.env.$DISPLAY"
chmod 0600 "$HOME/.env.$DISPLAY"
for var in DISPLAY XAUTHORITY DESKTOP_SESSION GDM_SESSION \
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

case "$@" in
  *xmonad-session*)
    ;;
  *gnome-session*)
    exec "$@"
    ;;
esac

for wm in $wm xmonad; do
  if type $wm >/dev/null 2>&1; then
    set -- $wm
    break
  fi
done

xsetroot -solid '#008080'

"$@" &
wmpid=$!

: ${XDG_CURRENT_DESKTOP:=${XDG_SESSION_DESKTOP:-${GDMSESSION:-Old}}}

sleep 0.5

if type dex >/dev/null 2>&1; then
  dex -a -e "$XDG_CURRENT_DESKTOP"
elif type xbindkeys >/dev/null 2>&1; then
  xbindkeys -n &
fi

wait $wmpid
