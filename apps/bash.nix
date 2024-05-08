{ vars, ... }:

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
          nh os switch
          ;;
        -h)
          nh home switch
          ;;
        -f)
          sudo nix flake update
          ;;
        "")
          nh os switch
          nh home switch
          ;;
        *)
          echo "Usage: rbld [-n|-h}"
          ;;
      esac
    }
    '';
  };
}