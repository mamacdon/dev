#!/bin/bash
# Use WINHOME if set
if [ -z "$WINHOME" ]; then
    WINHOME="$HOME/winhome"
fi

#C:\Users\10052628\scoop\apps\python\3.6.1\Scripts
export WORKON_HOME=$WINHOME/.virtualenvs

if [[ $(uname) != "Linux" ]] ; then
    . $WINHOME/scoop/apps/python/3.6.1/Scripts/virtualenvwrapper.sh
fi
