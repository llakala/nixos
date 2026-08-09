#!/usr/bin/env fish

set DIRECTORY (pwd -P)

switch (count $argv)
    case 0 1
        echo "Not enough arguments passed!"
        exit 1

    case 2
        set TMPDIR $argv[1]
        set TYPE $argv[2]

    case '*'
        echo "Error: Too many arguments passed"
        exit 1
end

function cleanup_state
    if [ -f /tmp/original.patch ]
        rm /tmp/original.patch
    end
end
trap cleanup_state EXIT

if [ -f /tmp/original.patch ]
    echo "File /tmp/original.patch already existed, when it was expected to not exist!"
    exit 1
end

switch $TYPE
    case hire kill
        # Unstaged diff
        git -C $DIRECTORY diff >/tmp/original.patch

    case fire
        # Staged diff
        git -C $DIRECTORY diff --staged >/tmp/original.patch

    case '*'
        echo "Unexpected type! Expected hire, fire, or kill."
        exit 1

end

cd $TMPDIR
gps /tmp/original.patch --hunk --output-dir . >/dev/null # Split up patch into individual hunks

# gps uses \ as a separator by default
ls -A | string replace --all \\ /
