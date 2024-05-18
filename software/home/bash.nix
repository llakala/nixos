{
  vars,
  ...
}:

{
  programs.bash =
  {
    enable = true;
    bashrcExtra = ''
    export NIX_PATH="home-manager=${vars.configDirectory}/defaults:$NIX_PATH"
    export HOME_MANAGER_CONFIG=${vars.configDirectory}/defaults/home-defaults.nix
    rbld()
    {
      case "$1" in
        -n)
          sudo nh os switch -u
          ;;
        -h)
          nh home switch -u
          ;;
        -f)
          sudo nix flake update
          ;;
        *)
          echo "Usage: rbld (-n|-h|-f)"
          ;;
      esac
    }
    '';
  };
}