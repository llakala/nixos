#!/usr/bin/env fish

set FZF_DEFAULT_OPTS \
    --border --highlight-line --no-separator --ansi --preview-window='75%' --preview-window="top" \
    --cycle --multi --reverse --scheme=path --tiebreak="pathname,index" --bind='ctrl-l:accept'

set DIRECTORY (pwd -P)

switch (count $argv)
    case 0
        echo "Not enough arguments passed!"
        exit 1

    case 1
        set TYPE $argv[1]

    case '*'
        echo "Error: Too many arguments passed"
        exit 1
end

switch $TYPE
    case hire
        # Unstaged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff | string collect)

        # Apply the given patch to the staged changes, staging it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply --cached -
        end

    case fire
        # Staged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff --staged | string collect)

        # Unapply the given patch to the staged changes, unstaging it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply --cached -R -
        end

    case kill
        # Unstaged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff | string collect)

        # Unapply the given patch from the unstaged changes, getting rid of it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply -R -
        end

    case '*'
        echo "Unexpected type! Expected hire, fire, or kill."
        exit 1

end

function cleanup_state
    if [ -f $TMPDIR ]
        rm -rf $TMPDIR
    end
    if [ -f /tmp/original.patch ]
        rm /tmp/original.patch
    end
end

trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early
set TMPDIR (mktemp -d)

echo $ORIGINAL_DIFF >/tmp/original.patch

cd $TMPDIR
gps /tmp/original.patch --hunk --output-dir . >/dev/null # Split up patch into individual hunks

# gps uses \ as a separator by default
set applied_patches (
    ls -A \
    | string replace --all \\ / \
    | fzf --with-shell='fish -c' --preview='cat $(echo {} | string replace --all / \\\\) | diff-so-fancy' \
    | string replace --all / \\
)

cd $DIRECTORY
for patch in $applied_patches
    set patch (string split " " $patch)
    apply_diff $TMPDIR $patch[1]
end

# $TMPDIR is cleaned up here automatically
