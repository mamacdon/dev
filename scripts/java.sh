#!/bin/env bash
mvn_version_set() {
  newver="$1"
  if [[ $newver == "" ]]; then
    echo "Usage: $0 x.y.z"
    return 1
  fi
  mvn versions:set -DgenerateBackupPoms=false "-DnewVersion=${newver}"
}