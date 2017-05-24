#!/bin/bash
DEV=$HOME/code/misc/dev
BIN="$HOME/bin"
OSX=".*Darwin.*"
BASH_ON_WINDOWS=".*Microsoft.*"

OS=$(uname -a)
if [[ "$OS" =~ $OSX ]]; then
    SUBLIME_USER="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
elif [[ "$OS" =~ $BASH_ON_WINDOWS ]]; then
    SUBLIME_USER="/mnt/c/Users/$(whoami)/AppData/Roaming/Sublime Text 3/Packages/User"
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
SUBLIME_PREFS=(
    'Default (OSX).sublime-keymap'
    'Default (Windows).sublime-keymap'
    'Preferences.sublime-settings'
    'SublimeLinter.sublime-settings'
)

function err() {
    echo $1 >&2
}

echo "Copy home"
for FILE in "${HOME_SCRIPTS[@]}"; do
    cp "$HOME/$FILE" "$DEV/home/$FILE" || err "Failed to copy $HOME/$FILE"
done

echo && echo "Copy bin"
for FILE in "${BIN_SCRIPTS[@]}"; do
    cp "$BIN/$FILE" "$DEV/scripts/$FILE" || err "Failed to copy $BIN/$FILE"
done

echo && echo "Copy Sublime"
for FILE in "${SUBLIME_PREFS[@]}"; do
    cp "$SUBLIME_USER/$FILE" "$DEV/sublime/$FILE" || err "Failed to copy $SUBLIME/$FILE"
done
