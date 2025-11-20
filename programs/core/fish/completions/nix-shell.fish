function _get_completions
    set -l current_token (commandline --current-token)

    # Lie to nix and pretend we're generating nix3 completions.
    set -l args (env NIX_GET_COMPLETIONS=4 nix shell -f "<nixpkgs>" "$current_token")
    string collect -- $args[2..-1]
end

complete -c nix-shell \
    -x -s p -l packages \
    -a '(_get_completions)'
