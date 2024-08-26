rbld()
{
    run_rbld() # Add any new files to git and pipe into nom
    {
        git -C $CONFIG_DIRECTORY add -AN &&
        "$@" |&
        nom || return
    }

    get_time() # Get flake.lock revisions times for the inputs we care about
    {
        jq -r '([.nodes["home-manager", "nixpkgs", "nixpkgs-unstable"].locked.lastModified] | join(""))' flake.lock
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
            OLD_TIME=$(get_time)
            rbld -f
            NEW_TIME=$(get_time)

            echo "Old time: $OLD_TIME" # Logs for debugging
            echo "New time: $NEW_TIME"

            if [[ $OLD_TIME != $NEW_TIME ]]; then
                rbld -b
                git -C $CONFIG_DIRECTORY commit -m "Update flake.lock" flake.lock -q
                git -C $CONFIG_DIRECTORY push
            else
                echo "No important updates to flake.lock, so skipping rebuild"
            fi
            ;;
        *)
            echo "Usage: rbld (-n|-h|-f|-b|-a)"
            ;;
    esac
}