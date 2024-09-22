{
  vars,
  hostVars,
  ...
}:

{
  hm.programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = false;

    autocd = true; # If empty directory given as command, interpret it as cd

    sessionVariables =
    {
      EDITOR = vars.editor;
    };
    shellAliases =
    {
      src = ". ~/.zshrc";
    };

    history =
    {
      path = "${hostVars.homeDirectory}/.zsh_history";

      size = 10000;
      save = 10000;

      share = true; # Share history between terminal sessions
      ignoreDups = true; # # Ignore duplicates only if they're right next to each other
    };

    initExtra =
    ''
      export CONFIG_DIRECTORY=${vars.configDirectory}
      source ${./options.sh}
      source ${./keybinds.sh}
      source ${./rbld.sh}

      evalue()
      (
        nix eval --json "${vars.configDirectory}#nixosConfigurations.${hostVars.hostName}.config.$1" | jq
      )
    '';
  };
}
