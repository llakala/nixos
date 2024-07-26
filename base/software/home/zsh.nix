{
  vars,
  ...
}:

{
  programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    enableCompletion = false;
    shellAliases =
    {
      shell = "nix develop ${vars.configDirectory} --impure";
    };
  };

  programs.zsh.initExtra =
  ''
  bindkey '^I' autosuggest-accept
  rbld()
  {
    run_rbld()
    {
      set -o pipefail && "$@" |& nom || return
    }

    rbld_shell()
    {
      "$@" && source ~/.zshrc
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