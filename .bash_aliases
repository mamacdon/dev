# Git aliases
alias ga="git add"
alias gcach="git commit --amend -C HEAD"
alias gb="git branch"
#alias gbug=git_bug
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log"
alias gk="gitk $@ &"
#alias glt="git glt"
alias glt="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
#alias glm="git glm"
#alias glp="git log --pretty=full"
#alias gp="git pull"
#alias grbi="git rbi"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gs="git status -sb"
alias gw="git show"
alias gss="git show --stat"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grpe=grep
alias edit="open -a 'Sublime Text' $@"

# CF stuff
alias push_new_app="~/bin/push_new_app.sh push"
alias cleanup_temp_apps="~/bin/push_new_app.sh cleanup"
alias target="$HOME/bin/target_cf.sh"

alias wsk="wsk -i"

# https://github.com/github/hub
#eval "$(hub alias -s)"
# this was annoying
#alias git=hub
