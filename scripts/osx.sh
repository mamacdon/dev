#!/bin/env bash
function query_port {
  PORT=$1
  if [[ $PORT == "" ]]; then
    echo "Usage: query_port PORTNUMBER"
    return 1
  fi
  sudo PORT=$PORT lsof -nP -i4TCP:$PORT | grep LISTEN
}
