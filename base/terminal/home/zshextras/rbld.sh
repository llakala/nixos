rbld()
{
    run_rbld() # Add any new files to git and pipe into nom
    {
        git add -AN && "$@" 2>&1 nom || return # 2>&1 is identical to |&, but vscode prefers it
    }

    rbld_shell() # Not setup yet, but will automatically source zshrc when modified
    {
        "$@" && source ~/.zshrc
    }

    case "$1" in
        -n)
            run_rbld sudo nixos-rebuild switch --flake /etc/nixos --show-trace
            ;;
        -h)
            run_rbld home-manager switch -b backup --flake /etc/nixos --show-trace
            ;;
        -f)
            sudo nix flake update /etc/nixos
            ;;
        -b)
            rbld -n && rbld -h
            ;;
        -a)
        rbld -f &&
        rbld -n &&
        rbld -h
        ;;
        *)
        echo "Usage: rbld (-n|-h|-f|-b|-a)"
        ;;
    esac
}