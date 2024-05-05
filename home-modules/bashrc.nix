{ ... }:

{
  programs.bash =
  {
    enable = true;
    bashrcExtra = ''
    export NIX_PATH="home-manager=/etc/nixos/config:$NIX_PATH"
    export HOME_MANAGER_CONFIG=/etc/nixos/config/home.nix
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
    ''
  };
}