{
  vars,
  hostVars,
  ...
}:

{
  programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = false;

    autocd = true; # If empty directory given as command, interpret it as cd

    sessionVariables =
    {
      EDITOR = "nano";
    };
    shellAliases =
    {
      shell = "nix develop ${vars.configDirectory} --impure";
    };

    history =
    {
      path = "${hostVars.homeDirectory}/.zsh_history";

      size = 10000;
      save = 10000;

      share = true; # Share history between terminal sessions
      ignoreDups = true; # # Ignore duplicates only if they're right next to each other
    };
  };

  programs.zsh.initExtra =
  ''
    source ${./zshextras/options.sh}
    source ${./zshextras/keybinds.sh}

    rbld()
    {
      run_rbld() # Add any new files to git and pipe into nom
      {
          git add -AN && "$@" |& nom || return # 2>&1 is identical to |&, but vscode prefers it
      }

      rbld_shell() # Not setup yet, but will automatically source zshrc when modified
      {
          "$@" && source ~/.zshrc
      }

      case "$1" in
          -n)
              run_rbld sudo nixos-rebuild switch --flake ${vars.configDirectory} --show-trace
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
