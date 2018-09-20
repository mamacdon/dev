#!/bin/bash
# Use WINHOME if set
if [ -z "$WINHOME" ]; then
    WINHOME="$HOME/winhome"
fi

export GOBIN="$HOME/code/go/bin"

[ -d "$WINHOME" ] && export GOPATH="$WINHOME/code/go"
[[ $(uname) == Darwin ]] && export GOPATH="$HOME/code/go"

# GOROOT is the location where Go package is installed on your system.
# eg. /usr/local/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
