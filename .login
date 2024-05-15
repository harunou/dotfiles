# ~/.login
# vim: set ft=sh:

function is_linux_console() {
  [ $TERM = "linux" ]
}

if is_linux_console; then 
  setterm --blank 15 --powersave powerdown
fi

if is_linux_console; then
  _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
  for i in $( cat $HOME/.Xresources | grep "\*color" | sed "$_SEDCMD" - | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
    echo -en "$i"
  done
  clear
fi
