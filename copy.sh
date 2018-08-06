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

function section() {
    echo
    echo "$@"
}

section "Copy home"
for FILE in "${HOME_SCRIPTS[@]}"; do
    cp "$HOME/$FILE" "$DEV/home/$FILE" || err "Failed to copy $HOME/$FILE"
done

section "Copy bin"
for FILE in "${BIN_SCRIPTS[@]}"; do
    cp "$BIN/$FILE" "$DEV/scripts/$FILE" || err "Failed to copy $BIN/$FILE"
done

section "Copy Sublime"
(
    cd "$SUBLIME_USER"
    find . -name '*.sublime-keymap'   -print -exec cp {} "$DEV/sublime" \;
    find . -name '*.sublime-settings' -print -exec cp {} "$DEV/sublime" \;
    # dont want these
    rm "$DEV/sublime/*LockTab*"
)

section "Copy vscode"
(
    cd "$HOME/AppData/Roaming/Code/User"
    cp keybindings.json "$DEV/vscode/" && echo keybindings.json
    cp settings.json    "$DEV/vscode/" && echo settings.json
)

section "Copy vim"
(
    cp ~/.vimrc "$DEV/home/" && echo ".vimrc"
)