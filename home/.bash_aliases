# Git aliases
alias gti=git
alias ga="git add"
alias gcach="git commit --amend -C HEAD"
alias gb="git branch"
#alias gbug=git_bug
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log"
#alias glt="git glt"
alias glt="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
#alias glm="git glm"
#alias glp="git log --pretty=full"
#alias gp="git pull"
#alias grbi="git rbi"
alias gp="git pull"
alias gpr="git pull --rebase"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias grv="git remote --verbose"
alias gs="git status -sb"
alias gw="git show"
alias gss="git show --stat"
alias gws="git show --stat"

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Misc
alias grpe=grep
alias edit="open -a 'Sublime Text' $@"
alias wsk="wsk -i"

# CF stuff
#alias push_new_app="~/bin/push_new_app.sh push"
#alias cleanup_temp_apps="~/bin/push_new_app.sh cleanup"
alias target="$HOME/bin/cf_target.sh"

# Docker
alias doecker=docker
alias dolcker=docker
alias dockerk=docker
alias docekr=docker
alias doicker=docker
alias dicekr=docker
alias dickewr=docker
alias dicker=docker

# Must be a function in order to get $@ plus & i guess?
function gk() {
	gitk "$@" &
}

# Called by .bash_profile after sourcing git-completion
function git_autocomplete_aliases() {
	# Autocompletion for aliases
	#__git_complete gco _git_checkout
	__git_complete ga _git_add
	__git_complete gb _git_branch
	__git_complete gp _git_pull
}

# interactive prompts don't work in cygwin/Git for windows
if uname | grep MINGW > /dev/null ; then
	alias cf='winpty cf'
	alias nvm=nodist
fi

# https://github.com/github/hub
#eval "$(hub alias -s)"
# this was annoying
#alias git=hub
