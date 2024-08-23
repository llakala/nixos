rbld()
{
    run_rbld() # Add any new files to git and pipe into nom
    {
        git -C $CONFIG_DIRECTORY add -AN &&
        "$@" |&
        nom || return
    }

    case "$1" in
        -n)
            run_rbld sudo nixos-rebuild switch --flake $CONFIG_DIRECTORY
            ;;
        -h)
            run_rbld home-manager switch -b backup --flake $CONFIG_DIRECTORY
            ;;
        -f)
            sudo nix flake update --flake $CONFIG_DIRECTORY
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