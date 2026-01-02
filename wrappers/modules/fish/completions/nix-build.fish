function _get_completions
    set -l tokens (__fish_print_cmd_args_without_options)
    set -l current_token (commandline --current-token)

    set -l file
    if set -q tokens[2]
        set file "$tokens[2]"
    else
        set file ./default.nix
    end

    # Lie to nix and pretend we're generating nix3 completions. This even works
    # for `<nixpkgs>`!
    set args (env NIX_GET_COMPLETIONS=4 nix build -f $file $current_token)
    string collect -- $args[2..-1]
end

complete -c nix-build \
    -x -s A -l attr \
    -a '(_get_completions)'
