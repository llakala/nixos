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
          sudo nh os switch -u
          ;;
        -h)
          sudo nix flake lock --update-input home-manager
          nh home switch -u
          ;;
        "")
          sudo nix flake update
          sudo nh os switch -u
          nh home switch -u
          ;;
        *)
          echo "Usage: rbld [-n|-h]"
          ;;
      esac
    }
    '';
  };
}