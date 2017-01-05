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

# Usage: npm_shrinkwrap_clean path/to/package.json
#
# Helper to generate a pristine npm-shrinkwrap.json file.
#
# Given a package.json, performs an npm install in a temp directory bypassing the npm cache,
# then generates a npm-shrinkwrap file to the same location as the provided package.json.
# Any preexisting npm-shrinkwrap.json will be renamed to `npm-shrinkwrap.json.1`.
#
npm_shrinkwrap_clean() {
    FILE="$1"
    DEST=$(cd $(dirname "$FILE") && pwd)
    [ ! -z "$FILE" ] || { nodejs_helper_error "Usage: shrinkwrap_clean /path/to/package.json" && return 1 ; }
    [ -f "$FILE" ]   || { nodejs_helper_error "File does not exist: $FILE" && return 1 ; }
    # TODO --production flag
    PRODUCTION=""

    TMPDIR=$(mktemp -d)
    cp "$FILE" "$TMPDIR"

    # Copy file: dependencies, if any - these must be in the temp folder or npm install will fail
    for FILEDEP in $(jq < ${FILE} .dependencies,.optionalDependencies | grep 'file:' | awk '{print $2}' | tr -d '",' | cut -d ':' -f2); do
        echo "Copy 'file:' dependency: $FILEDEP to $TMPDIR"
        cp -r --parents "$FILEDEP" "$TMPDIR"
    done

    pushd "$TMPDIR" &>/dev/null
    trap nodejs_helper_cleanup RETURN  # restore original dir before exiting

    if npm cache clear \
        && npm set progress=false \
        && npm install ${PRODUCTION} \
        && npm shrinkwrap \
        && nodejs_helper_copy_with_backup "${TMPDIR}/npm-shrinkwrap.json" "${DEST}"
    then
        echo "Wrote ${DEST}/npm-shrinkwrap.json"
    else
        # Hosed
        nodejs_helper_error "^^^ Failed :("
        return 1
    fi
}