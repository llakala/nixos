rbld()
( # Run in subshell so the cd is undone after rebuilding
    cd $CONFIG_DIRECTORY

    run_rbld() # Add any new files to git and pipe command output into `nom`
    {
        git add -AN &&
        "$@" |&
        nom || return
    }

    get_time() # Get flake.lock revisions times for the inputs we care about
    {
        jq -r '([.nodes["home-manager", "nixpkgs", "nixpkgs-unstable"].locked.lastModified] | add)' flake.lock
    }

    case "$1" in
        -n)
            run_rbld sudo nixos-rebuild switch --flake $CONFIG_DIRECTORY
            ;;
        -h)
            run_rbld home-manager switch -b backup --flake $CONFIG_DIRECTORY
            ;;
        -b)
            rbld -n && rbld -h
            ;;
        -f)
            OLD_TIME=$(get_time)
            sudo nix flake update --flake $CONFIG_DIRECTORY
            NEW_TIME=$(get_time)

            echo "Old time: $OLD_TIME" # Logs for debugging
            echo "New time: $NEW_TIME"

            if [[ $NEW_TIME == $OLD_TIME ]]; then
                echo "No important updates to flake.lock, so skipping rebuild"
                exit 0
            fi

            if ! rbld -b; then
                echo "Rebuild failed, not committing changes"
                exit 1
            fi

            git commit -q -m "flake: update flake.lock" flake.lock
            git push
            ;;
        *)
            cat << EOT
Usage: rbld (-n|-h|-f|-b|-a)
Options:
  -n        Rebuild the system configuration (akin to nixos-rebuild switch)
  -h        Rebuild the home-manager configuration (akin to home-manager switch)
  -b        Rebuild both the system and home-manager configurations
  -f        Update the flake.lock and rebuild if necessary
EOT
            ;;
    esac

)