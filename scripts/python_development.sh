#!/bin/bash
# Use WINHOME if set
if [ -z "$WINHOME" ]; then
    WINHOME="$HOME/winhome"
fi

#C:\Users\10052628\scoop\apps\python\3.6.1\Scripts
export WORKON_HOME=$WINHOME/.virtualenvs

# if [[ $(uname) != "Linux" ]] ; then
#     . $WINHOME/scoop/apps/python/3.6.1/Scripts/virtualenvwrapper.sh
# fi

export PYTHONIOENCODING=UTF-8

if [[ $(uname) == "Darwin" ]]; then
    # For commands that are too dumb to call python3,
    # put a python in the PATH before MacOS's garbage python
    true
    # export PATH="/usr/local/Cellar/python/3.7.2_2/bin:$PATH"
    # (
    #     cd /usr/local/Cellar/python/3.7.2_2/bin
    #     [ ! -s python ] && ln -s python3 python
    # )
    # export PATH="$PATH:/usr/local/opt/sphinx-doc/bin:$HOME/Library/Python/3.7/bin"
fi

# if command -v pyenv 1>/dev/null 2>&1; then
#     #eval "$(pyenv init -)"
#     #eval "$(pyenv virtualenv-init -)"
# fi
