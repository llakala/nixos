{
  vars,
  ...
}:

{
  programs.bash =
  {
    enableCompletion = true;
    bashrcExtra = ''
    rbld()
    {
      case "$1" in
        -n)
          sudo nixos-rebuild switch --flake ${vars.configDirectory} --show-trace --fast |& nom
          ;;
        -h)
          home-manager switch --flake ${vars.configDirectory} --show-trace |& nom
          ;;
        -f)
          sudo nix flake update ${vars.configDirectory} |& nom
          ;;
        -b)
          rbld -n
          rbld -h
          ;;
        -a)
          rbld -f
          rbld -n
          rbld -h
          ;;
        *)
          echo "Usage: rbld (-n|-h|-f|-b|-a)"
          ;;
      esac
    }
    '';
  };
}