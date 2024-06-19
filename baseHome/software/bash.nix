{
  vars,
  ...
}:

{
  programs.bash =
  {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
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