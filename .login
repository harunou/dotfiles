# ~/.login
# vim:set et sw=2:

function is_linux_console() {
  [[ $TERM == "linux" ]]
}

if is_linux_console; then 
  setterm --blank 15 --powersave powerdown
fi

