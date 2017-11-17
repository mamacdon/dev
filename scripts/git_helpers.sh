#!/bin/bash

# Delete branches matching $1
git_delete_branches() {
    REGEX=${1?"Usage: git_delete_BRANCHes REGEX"}
    local TO_DELETE=()
    for BRANCH in $(git branch); do
        [[ $BRANCH =~ $REGEX ]] && TO_DELETE+=("${BRANCH}")
    done

    for BRANCH in ${TO_DELETE[@]} ; do
        gb -D $BRANCH
    done
}