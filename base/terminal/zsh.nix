{
  vars,
  hostVars,
  pkgs,
  ...
}:

{
  programs.zsh.enable = true; # Required to set environment.shells
  environment.shells = with pkgs; [ zsh ];
  users.users.${hostVars.username}.shell = pkgs.zsh;

  hm.programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = false;
    autocd = true; # If empty directory given as command, interpret it as cd

    sessionVariables.EDITOR = vars.editor;
    shellAliases.src = ". ~/.zshrc";

    history =
    {
      path = "${hostVars.homeDirectory}/.zsh_history";

      size = 100000;
      save = 100000;

      share = true; # Share history between terminal sessions
      ignoreDups = true; # # Ignore duplicates only if they're right next to each other
      expireDuplicatesFirst = true;
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
