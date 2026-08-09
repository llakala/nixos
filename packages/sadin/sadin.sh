#!/usr/bin/env bash

DIRECTORY=$(pwd -P)

case $# in
    0 | 1)
        echo "Not enough arguments passed!"
        exit 1
        ;;
    2)
        TMPDIR=$1
        TYPE=$2
        ;;
    *)
        echo "Error: Too many arguments passed"
        exit 1
        ;;
esac

function cleanup_state() {
    if [[ -f /tmp/original.patch ]]; then
        rm /tmp/original.patch
    fi
}
trap cleanup_state EXIT

if [[ -f /tmp/original.patch ]]; then
    echo "File /tmp/original.patch already existed, when it was expected to not exist!"
    exit 1
fi

case $TYPE in
    hire | kill)
        # Unstaged diff
        git -C "$DIRECTORY" diff >/tmp/original.patch
        ;;

    fire)
        # Staged diff
        git -C "$DIRECTORY" diff --staged >/tmp/original.patch
        ;;

    *)
        echo "Unexpected type! Expected hire, fire, or kill."
        exit 1
        ;;
esac

cd "$TMPDIR"
gps /tmp/original.patch --hunk --output-dir . >/dev/null # Split up patch into individual hunks

files=$(ls -A)
if [[ -n $files ]]; then
  # gps uses \ as a separator by default, replace it with normal slashes for
  # viewing purposes
  echo "${files//\\//}"
fi
