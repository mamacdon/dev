#!/bin/bash
DEV=$HOME/code/misc/dev
BIN="$HOME/bin"
SUBLIME_USER="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

HOME_SCRIPTS=('.bash_aliases' '.gitconfig')
BIN_SCRIPTS=('go_development.sh' 'git-link.sh' 'home.mamacdon.ca.sh' 'lock_screen.sh' 'nodejs_helpers.sh')
SUBLIME_PREFS=('Default (OSX).sublime-keymap' 'Preferences.sublime-settings' 'SublimeLinter.sublime-settings')

function err() {
    echo $1 >&2
}

for FILE in "${HOME_SCRIPTS[@]}"; do
    cp "$HOME/$FILE" "$DEV/home/$FILE" || err "Failed to copy $HOME/$FILE"
done

for FILE in "${BIN_SCRIPTS[@]}"; do
    cp "$BIN/$FILE" "$DEV/scripts/$FILE" || err "Failed to copy $BIN/$FILE"
done

for FILE in "${SUBLIME_PREFS[@]}"; do
    cp "$SUBLIME_USER/$FILE" "$DEV/sublime/$FILE" || err "Failed to copy $SUBLIME/$FILE"
done
