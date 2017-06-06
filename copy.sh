#!/bin/bash
function err() {
    echo $1 >&2
}

DEV=$HOME/code/misc/dev
BIN="$HOME/bin"
OSX=".*Darwin.*"
BASH_ON_WINDOWS=".*Microsoft.*"
GIT_FOR_WINDOWS=".*MINGW.*"

OS=$(uname -a)
if [[ "$OS" =~ $OSX ]]; then
    SUBLIME_USER="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
elif [[ "$OS" =~ $BASH_ON_WINDOWS ]]; then
    SUBLIME_USER="/mnt/c/Users/$(whoami)/AppData/Roaming/Sublime Text 3/Packages/User"
elif [[ "$OS" =~ $GIT_FOR_WINDOWS ]]; then
    SUBLIME_USER="$HOME/AppData/Roaming/Sublime Text 3/Packages/User"
else
    err "unknown OS $OS"
    exit 1
fi

HOME_SCRIPTS=('.bash_aliases' '.gitconfig')
BIN_SCRIPTS=(
    'go_development.sh'
    'git-link.sh'
    'home.mamacdon.ca.sh'
    'lock_screen.sh'
    'nodejs_helpers.sh'
)

echo "Copy home"
for FILE in "${HOME_SCRIPTS[@]}"; do
    cp "$HOME/$FILE" "$DEV/home/$FILE" || err "Failed to copy $HOME/$FILE"
done

echo && echo "Copy bin"
for FILE in "${BIN_SCRIPTS[@]}"; do
    cp "$BIN/$FILE" "$DEV/scripts/$FILE" || err "Failed to copy $BIN/$FILE"
done

echo && echo "Copy Sublime"
(
    cd "$SUBLIME_USER"
    find . -name '*.sublime-keymap'   -print -exec cp {} "$DEV/sublime" \;
    find . -name '*.sublime-settings' -print -exec cp {} "$DEV/sublime" \;
)
