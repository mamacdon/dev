#!/bin/bash

# Print out the SHA of HEAD
#HEAD_SHA=`git log -1 | head -n 1 | cut -c 8-`
#if [[ ]] ; then 
#else
#fi

# Sets HEAD_SHA and HEAD_SHA_LONG
set_head_sha() {
    if [[ ! -z "$1" ]] ; then
        rev="$1"
    else
        rev=HEAD
    fi
    HEAD_SHA=`git rev-parse --short ${rev}`
    HEAD_SHA_LONG=`git rev-parse ${rev}`
}

# Prints the URL where the given revision can be viewed.
# $1 the revision (optional, if empty HEAD is assumed)
print_commit_url() {
    set_head_sha "$@"

    # Generate a commit link if we know how for the remote

    # Get the non-origin remote URLs
    REMOTES=$(git remote -v | grep -v origin | awk '{ print $2 }')
    # Put the origin URL at the end of the list, so it "wins" over any other remotes
    REMOTES="${REMOTES} $(git remote show origin | grep URL | awk '{print $3}')"

    REPO_URL=""
    for URL in $REMOTES ; do
        case "$URL" in
            *.eclipse.org*)
                if [[ "$REMOTES" == *client.git* ]]; then
                    REPO_NAME=org.eclipse.orion.client.git
                else
                    REPO_NAME=org.eclipse.orion.server.git
                fi
                REPO_URL=http://git.eclipse.org/c/orion/${REPO_NAME}/commit/?id=${HEAD_SHA}
                ;;

            # Github and github enterprise
            #    git@github.ibm.com:org-ids/otc-setup-ui.git OR
            #    https://github.ibm.com/mamacdon/cleanup-toolchain-repos.git
            # -> https://github.ibm.com/:user/:repo/commit/5be891ba36aabaa128b5db8705e8aadc150a338a
            *github.com* | *github.ibm.com* | *github*bluemix*)
                if [[ $REPO_URL =~ "git@" ]]; then
                    # Rewrite git@{server}:{user}/{repo}.git to https://{server}/{user}/{repo}/commit/
                    REPO_URL=$(echo "$URL" | sed -E 's#.+@([^:]+):([^/]+)/(.+)\.git#https://\1/\2/\3/commit/#')
                else
                    # Rewrite https://____/:user/:repo.git
                    REPO_URL=$(echo "$URL" | sed -E 's#.+//([^/]+)/([^/]+)/(.+)\.git#https://\1/\2/\3/commit/#')
                fi
                # Append the sha
                REPO_URL="${REPO_URL}${HEAD_SHA}"
                ;;

            *hub.jazz.net*)
                ## Rewrite /git/:user/:repo to /project/:user/:repo/commit/:HEAD_SHA_LONG
                REPO_URL=$(echo "$URL" | sed -E 's#git/([^/]+)/([^/]+)#project/\1/\2/commit/#')
                REPO_URL="${REPO_URL}${HEAD_SHA_LONG}"
                ;;

            *github.rtp*)
                REPO_URL_PREFIXES=$(git remote -v \
                    | awk '{ print $2 }' \
                    | grep github.rtp \
                    | sed -E 's#git\@github.rtp.raleigh.ibm.com:(.+?)\/(.+?).git.*#https://github.rtp.raleigh.ibm.com/\1/\2/commit/#g' \
                    | tr ' ' '\n' \
                    | uniq)
                # shitty join with # so we can split later with tr
                for url in $REPO_URL_PREFIXES; do
                    REPO_URL="$REPO_URL$url${HEAD_SHA_LONG}%"
                done
                ;;
        esac
    done
    echo "$REPO_URL"
}


### Here's the old crappy way
# if [[ "$REMOTES" == *.eclipse.org* ]] ; then
#     if [[ "$REMOTES" == *client.git* ]]; then
#         REPO_NAME=org.eclipse.orion.client.git
#     else
#         REPO_NAME=org.eclipse.orion.server.git
#     fi
#     REPO_URL=http://git.eclipse.org/c/orion/${REPO_NAME}/commit/?id=${HEAD_SHA}
# elif [[ "$REMOTES" == *idsorg/IDS.Web.IDE* ]] ; then
#     REPO_URL=https://hub.jazz.net/project/idsorg/IDS%20Web%20IDE/commit/${HEAD_SHA}
# elif [[ "$REMOTES" == *github.rtp* ]] ; then
#     #git@github.rtp.raleigh.ibm.com:{user}/{project}.git
#     REPO_URL_PREFIXES=$(git remote -v \
#         | awk '{ print $2 }' \
#         | grep github.rtp \
#         | sed -E 's#git\@github.rtp.raleigh.ibm.com:(.+?)\/(.+?).git.*#https://github.rtp.raleigh.ibm.com/\1/\2/commit/#g' \
#         | tr ' ' '\n' \
#         | uniq)
#     # shitty join with # so we can split later with tr
#     for url in $REPO_URL_PREFIXES; do
#         REPO_URL="$REPO_URL$url${HEAD_SHA_LONG}%"
#     done
# # TODO Github
# fi

REPO_URL=$(print_commit_url "$@")

set_head_sha "$@"
echo "${rev} SHA-1 (short):"
echo "${HEAD_SHA}"
echo
echo "${rev} SHA-1:"
echo "${HEAD_SHA_LONG}"

if [[ "$REPO_URL" != "" ]] ; then
    echo
    echo "Commit URL:"
    echo ${REPO_URL} | tr '#' '\n'
fi
