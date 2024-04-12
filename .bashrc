# ~/.bashrc
# vim: set ft=sh:

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# navigate directories without cd
shopt -s autocd

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'
# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Do not display a list of the matching files
bind "set show-all-if-ambiguous off"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

alias ls='ls --color=auto'

PROMPT_TRIM_LENGTH=40
PS1='\u@\h $(p=${PWD/#"$HOME"/~};((${#p}>$PROMPT_TRIM_LENGTH))&&echo "..${p:(-38)}"||echo "\w") \$ '
