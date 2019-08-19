#!/bin/bash
nodejs_helper_error() {
    echo $@ >&2
}

# Copy file $1 to directory $2. If a file with the same name already exists in $2 it is renamed.
nodejs_helper_copy_with_backup() {
    [ ! -f "$1" ] && nodejs_helper_error "Argument is missing or is not a file: $1"
    [ ! -d "$2" ] && nodejs_helper_error "Argument is missing or is not a directory: $2"

    set -x
    SRC="$1"
    DEST_DIR="$2"
    FILENAME=$(basename "$1")
    TARGET="${DEST_DIR}/${FILENAME}"
    set +x
    if [ -e "$TARGET" ]; then
        echo "Moving existing ${TARGET} to ${TARGET}.1"
        mv "$TARGET" "$TARGET.1"
    fi
    cp "$SRC" "$TARGET" && return 0

    return 1
}

nodejs_helper_cleanup() {
    popd &>/dev/null
    # if [[ "$TMPDIR" =~ "/tmp" ]]; then
    #     echo "Clean temp dir $TMPDIR"
    #     ##rm -rf "$TMPDIR"
    # fi
}

spotlight_nodejs_index_exclude() {
    find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;
}

# Prints the names of .js files under the CWD, excluding node_modules
find_js_files() {
    #find . -path ./node_modules -prune -o -name '*.js' "$@"
    find . -type d \( -path ./node_modules -o -path ./dist -o -path ./build \) -prune -o -name '*.js' -print
}