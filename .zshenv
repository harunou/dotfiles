# ~/.zshenv
# vim: ft=sh sw=2

if [[ -z "$ENV" && -n "$PATH" ]]; then
  case $- in
    *l*) 
      # NOTE(harunou): for interactive shell do nothing
      ;;
    *) 
      . "$HOME/.profile"
      ;;
  esac
fi

GRML_DISPLAY_BATTERY=1
