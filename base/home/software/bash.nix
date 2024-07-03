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
          sudo nixos-rebuild switch --flake ${vars.configDirectory} --show-trace --fast
          ;;
        -h)
          home-manager switch --flake ${vars.configDirectory} --show-trace
          ;;
        -f)
          sudo nix flake update ${vars.configDirectory}
          ;;
        -a)
          rbld -f
          rbld -n
          rbld -h
          ;;
        *)
          echo "Usage: rbld (-n|-h|-f|-a)"
          ;;
      esac
    }
    '';
  };
}