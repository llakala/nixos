function _nixpkgs_completions
    # Lie to nix and pretend we're generating the flakey completions
    set -l current_token (commandline --current-token)
    set -l old_args (env NIX_GET_COMPLETIONS=2 nix shell "nixpkgs#$current_token")

    for arg in $old_args
        # nix gives the completions in the form of: "nixpkgs#foo"
        # We need to get just the foo part.
        # TODO: is there a faster way to do this?
        set -a new_args (string sub --start=9 $arg)
    end

    string collect -- $new_args[2..-1]
end

complete -c nix-shell \
    -x -s p -l packages \
    -a '(_nixpkgs_completions)'
