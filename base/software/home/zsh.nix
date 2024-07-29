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

  setopt AUTO_CD
  setopt INTERACTIVE_COMMENTS
  setopt PIPEFAIL

  export EDITOR=nano
  export VISUAL="$EDITOR"

  export HISTSIZE=10000
  export SAVEHIST=10000
  setopt APPEND_HISTORY
  setopt HIST_IGNORE_ALL_DUPS
  setopt SHARE_HISTORY
  setopt HIST_REDUCE_BLANKS


  rbld()
  {
    run_rbld()
    {
      git add -AN && "$@" |& nom || return
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
        sudo nix flake update ${vars.configDirectory}
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
