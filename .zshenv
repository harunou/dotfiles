# ~/.zshenv
# vim: set ft=sh:

if [[ -z "$ENV" && -n "$PATH" ]]; then
  case $- in
    *l*) 
      # NOTE(harunou): for interactive shell do nothing
      ;;
    *) 
      . "$HOME/.profile"
      GRML_DISPLAY_BATTERY=1
      ;;
  esac
fi

