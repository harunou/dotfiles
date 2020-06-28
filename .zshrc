# ~/.zshrc
# vim:set et sw=2:

. $HOME/.zshrc.grml
. $HOME/.zshrc.grml.help

. $HOME/.zshrc.git

alias h="harunou"

alias logg="journalctl -r -b 0"
alias loga="journalctl -r"
alias lap="list_all_pager"
alias dir="ls -lsAh --group-directories-first"
alias lsf="ls *(.)"
alias lsdnew="lsnewdir"
alias lsdold="lsolddir"
alias mkt="cdt"
alias cdl="cl"
alias mcd="mkcd"
alias rmad="rmcdir"
alias sax="simple-extract"
alias grmlhelp="zsh_grml_help_all | $PAGER"
alias grmlhelpglob="zsh_grml_help_glob | $PAGER"
alias grmlhelpcommands="zsh_grml_help_commands | $PAGER"
alias grmlhelphashes="zsh_grml_help_hashes | $PAGER"
alias grmlhelpkeybindings="zsh_grml_help_keybindings | $PAGER"
alias grmlhelpkeybindings="zsh_grml_help_expansion | $PAGER"
alias githelpaliases="cat $HOME/.zshrc.git | $PAGER"
alias gim="git import"
alias gex="git export"

hash -d Downloads=$HOME/Downloads

if [[ -n "$NVM_DIR" ]]; then
  alias nvmstart="source $NVM_DIR/nvm.sh"
fi

function list_all_pager() {
  ls -la $1 | $PAGER
}

[ ! -f "$HOME/.zshrc.local" ] || . "$HOME/.zshrc.local"
