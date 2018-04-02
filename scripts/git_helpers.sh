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

# Usage: git_push_to_remote [-f] REMOTE LOCAL_REF REMOTE_REF
git_push_to_remote() {
    local usage="git_push_to_remote [-f] REMOTE LOCAL_REF REMOTE_REF"
    local force=""
    while [[ "$#" -gt 0 ]]; do
        local arg="$1"
        case "$arg" in
            -f|--force) force="--force" ;;
            *)
                [[ -z "$remote" ]] && remote="$arg"
                [[ -z "$local_ref" ]] && local_ref="$arg"
                [[ -z "$remote_ref" ]] && remote_ref="$arg"
                ;;
        esac
    done

    : ${remote?"$usage"}
    : ${local_ref?"$usage"}
    : ${remote_ref?"$usage"}

    echo "Push local ref ${local_ref} to ${remote}/${remote_ref}..."
    git push ${force} "${remote}" "${local_ref}:refs/heads/${remote_ref}"
}