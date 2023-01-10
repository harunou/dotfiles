# ~/.zshrc
# vim: ft=sh sw=2

. $HOME/.shrc
. $HOME/.grml.zsh
. $HOME/.grml.help.zsh

alias lsf="ls *(.)"
alias lsdnew="lsnewdir"
alias lsdold="lsolddir"
alias mkt="cdt"
alias cdl="cl"
alias mcd="mkcd"
alias rmad="rmcdir"
alias sax="simple-extract"
alias helpgrml="zsh_grml_help_all | $PAGER"
alias helpgrmlglob="zsh_grml_help_glob | $PAGER"
alias helpgrmlcommands="zsh_grml_help_commands | $PAGER"
alias helpgrmlhashes="zsh_grml_help_hashes | $PAGER"
alias helpgrmlkeybindings="zsh_grml_help_keybindings | $PAGER"
alias helpgrmlkeybindings="zsh_grml_help_expansion | $PAGER"

hash -d Downloads=$HOME/Downloads


[ ! -f "$HOME/.zshrc.local" ] || . "$HOME/.zshrc.local"
