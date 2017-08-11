#!/bin/bash
# Use WINHOME if set
if [ -z "$WINHOME" ]; then
    WINHOME="$HOME/winhome"
fi

export GOBIN="$HOME/code/go/bin"
export GOPATH="$WINHOME/code/go"
# GOROOT is the location where Go package is installed on your system.
# eg. /usr/local/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
