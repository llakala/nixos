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
    rbld()
    {
      case "$1" in
        -n)
          nh os switch -u
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