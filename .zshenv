# ~/.zshenv
# vim:set et sw=2:

if [ -z "$ENV" -a -n "$PATH" ]; then
  case $- in
    *l*) ;;
    *) . "$HOME/.profile" >/dev/null 
      ;;
  esac
fi

zshcache=$HOME/.cache/zsh
[ -d $zshcache ] || mkdir -p $zshcache
HISTFILE=$zshcache/.zsh_history
COMPDUMPFILE=$zshcache/.zcompdump
DIRSTACKFILE=$zshcache/.zdirs
