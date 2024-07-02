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
          sudo nixos-rebuild switch --fast --show-trace
          ;;
        -h)
          home-manager switch --flake ${vars.configDirectory} --show-trace
          ;;
        -f)
          sudo nix flake update
          ;;
        -a)
          rbld -f
          rbld -n
          rbld -h
          ;;
        *)
          echo "Usage: rbld (-n|-h|-a|-f)"
          ;;
      esac
    }
    '';
  };
}