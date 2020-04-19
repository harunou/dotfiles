# ~/.zshrc
# vim:set et sw=2:

. $HOME/.zshrc.grml
. $HOME/.zshrc.grml.help

alias dir="ls -lsAh --group-directories-first"
alias lsf="ls *(.)"
alias lsdnew="lsnewdir"
alias lsdold="lsolddir"
alias mkt="cdt"
alias cdl="cl"
alias mcd="mkcd"
alias rmid="rmcdir"
alias sax="simple-extract"
alias grmlhelp="zsh_grml_help_all | less"
alias grmlhelpglob="zsh_grml_help_glob | less"
alias grmlhelpcommands="zsh_grml_help_commands | less"
alias grmlhelphashes="zsh_grml_help_hashes | less"
alias grmlhelpkeybindings="zsh_grml_help_keybindings | less"
alias grmlhelpkeybindings="zsh_grml_help_expansion | less"

# . $HOME/.zshrc.git

if [[ -n "$NVM_DIR" ]]; then
  alias startnvm="source $NVM_DIR/nvm.sh"
fi
