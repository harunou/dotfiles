# ~/.zshrc
# vim: set ft=sh:

. $HOME/.shrc
. $HOME/.grml.zsh
. $HOME/.grml.help.zsh
. $HOME/.local/bin/harunou-completion.zsh

# listing stuff
#a2# Execute \kbd{ls -lSrah}
alias dir="ls -lSrah"
#a2# Only show dot-directories
alias lad='ls -d .*(/)'
#a2# Only show dot-files
alias lsa='ls -a .*(.)'
#a2# Only files with setgid/setuid/sticky flag
alias lss='ls -l *(s,S,t)'
#a2# Only show symlinks
alias lsl='ls -l *(@)'
#a2# Display only executables
alias lsx='ls -l *(*)'
#a2# Display world-{readable,writable,executable} files
alias lsw='ls -ld *(R,W,X.^ND/)'
#a2# Display the ten biggest files
alias lsbig="ls -flh *(.OL[1,10])"
#a2# Only show directories
alias lsd='ls -d *(/)'
#a2# Only show empty directories
alias lse='ls -d *(/^F)'
#a2# Display the ten newest files
alias lsnew="ls -rtlh *(D.om[1,10])"
#a2# Display the ten oldest files
alias lsold="ls -rtlh *(D.Om[1,10])"
#a2# Display the ten smallest files
alias lssmall="ls -Srl *(.oL[1,10])"
#a2# Display the ten newest directories and ten newest .directories
alias lsnewdir="ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
#a2# Display the ten oldest directories and ten oldest .directories
alias lsolddir="ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"

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
alias np="h np"

hash -d Downloads=$HOME/Downloads

[ ! -f "$HOME/.zshrc.local" ] || . "$HOME/.zshrc.local"

