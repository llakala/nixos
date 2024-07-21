{
  vars,
  ...
}:

{
  programs.bash =
  {
    enable = true;
    enableCompletion = true;
    shellAliases =
    {
      shell = "nix develop ${vars.configDirectory} --impure";
    };
  };

  programs.bash.bashrcExtra =
  ''
  rbld()
  {
    run_rbld()
    {
      set -o pipefail && "$@" |& nom || return
    }
    
    case "$1" in
      -n)
        run_rbld sudo nixos-rebuild switch --flake ${vars.configDirectory} --show-trace --fast
        ;;
      -h)
        run_rbld home-manager switch -b backup --flake ${vars.configDirectory} --show-trace
        ;;
      -f)
        run_rbld sudo nix flake update ${vars.configDirectory}
        ;;
      -b)
        rbld -n && rbld -h
        ;;
      -a)
        rbld -f &&
        rbld -n &&
        rbld -h
        ;;
      *)
        echo "Usage: rbld (-n|-h|-f|-b|-a)"
        ;;
    esac
  }
  '';
}