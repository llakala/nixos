{ vars, ... }:

{
  programs.bash =
  {
    enable = true;
    bashrcExtra = ''
    export NIX_PATH="home-manager=${vars.configPath}/defaults:$NIX_PATH"
    export HOME_MANAGER_CONFIG=/etc/nixos/defaults/home-defaults.nix
    rbld()
    {
      case "$1" in
        -n)
          nh os switch
          ;;
        -h)
          nh home switch
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