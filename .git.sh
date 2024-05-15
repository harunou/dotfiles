# ~/.git.sh
# vim: set ft=sh:
# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

alias g='git'

alias gcl='git clone --recurse-submodules'

alias gst='git status'
alias gss='git status -s'
alias gsb='git status -sb'

alias gb='git branch'
alias gbv="git branch -vv"
alias gba='git branch -a'
alias gbr='git branch --remote'
alias gbnm='git branch --no-merged'
alias gbrn='git branch -m' # rename 
alias gbrename='grename' #rename with remote
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbdm='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbdg='confirm_and_delete_gone_branch'
alias gfa='git fetch --all --prune'

alias gco='git checkout'
alias gcoa='git checkout -- .'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gcd='git checkout develop'

alias ga='git add'
alias gaa='git add .'

alias gc='git commit'
alias gc!='git commit --amend'
alias gcn!='git commit --no-edit --amend' # do not show commit diallog

alias gsta='git stash push'
alias gstm='git stash push -m' # setup message for stash
alias gstu='git stash --include-untracked'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gsts='git stash show --text' # show patch

alias gl='git pull'
alias gpull='git pull origin "$(git_current_branch)"'

alias gp='git push origin'
alias gpp='git push'
alias gpd='git push --dry-run'
alias gpf='git push origin --force-with-lease'
alias gppf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpush='git push -u origin "$(git_current_branch)"'

alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grd='git rebase -i develop'
alias grm='git rebase -i master'

alias gd='git diff'
alias gdw='git diff --word-diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms='git merge --squash --ff'
alias gmt='git mergetool --no-prompt'

alias gt='git reset'
alias gth='git reset --hard'
alias gtho='git reset origin/$(git_current_branch) --hard'
alias gpristine='git reset --hard && git clean -dffx'

alias gbl='git blame -b -w'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

alias gcf='git config --list'

alias gclean='git clean -id'

alias gcount='git shortlog -sn'
alias glo='git --no-pager show -s'
alias glog='git log'
#https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs
#Basic graph log
alias gloga='git log --graph --color --decorate --all'
#Extended look
alias glogg='git log --color --date-order --graph --oneline --decorate'
alias glogga='git log --color --date-order --graph --oneline --decorate --all'
#Quick look 
alias gloggs='git log --color --date-order --graph --oneline --decorate --simplify-by-decoration'
alias gloggsa='git log --color --date-order --graph --oneline --decorate --simplify-by-decoration --all'
#Look with date
alias glogd='git log --color --date-order --date="format:%d.%m.%y %H:%M" --graph --format="%C(auto)%h%Creset %C(blue bold)%ad%Creset %C(auto)%d%Creset %s"'
alias glogda='git log --color --date-order --date="format:%d.%m.%y %H:%M" --graph --format="%C(auto)%h%Creset %C(blue bold)%ad%Creset %C(auto)%h%Creset%C(auto)%d%Creset %s" --all'
#Look with relative date
alias glogdr='git log --color --date-order --graph --format="%C(auto)%h%Creset %C(blue bold)%ar%Creset %C(auto)%d%Creset %s"'
alias glogdra='git log --color --date-order --graph --format="%C(auto)%h%Creset %C(blue bold)%ar%Creset %C(auto)%d%Creset %s" --all'
#Look with commit owner (author)
alias gloggo='git log --color --date-order --graph --format="%C(auto)%h%Creset %C(auto)%an%Creset %C(auto)%d%Creset %s"'
alias glogdo='git log --color --date-order --date="format:%d.%m.%y %H:%M" --graph --format=\"%C(auto)%h%Creset %C(blue bold)%ad%Creset %C(auto)%an%Creset %C(auto)%d%Creset %s"'
alias glogdro='git log --color --date-order --graph --format="%C(auto)%h%Creset %C(blue bold)%ar%Creset %C(auto)%an%Creset %C(auto)%d%Creset %s"'

alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'

alias gfg='git ls-files | grep'

alias grev='git revert'

alias gts='git tag -s'
alias gtv='git tag | sort -V'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

function confirm_and_delete_gone_branch() {
  gone_branches=$(git branch -vv | awk '/: gone]/{print $1}')
  while read -u 3 -r branch; do
    echo -ne "Delete gone branch '$branch' [Y/n]? "
    read choice
    case "$choice" in 
      y|Y ) git branch -D $branch
	;;
      * ) echo "Skipping '$branch'" 
	;;
    esac
  done 3<<< "$gone_branches"
}

