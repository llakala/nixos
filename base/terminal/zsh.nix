{
  config,
  pkgs,
  ...
}:

{
  programs.zsh.enable = true; # Required to set environment.shells
  environment.shells = with pkgs; [ zsh ];
  users.users.${config.hostVars.username}.shell = pkgs.zsh;

  hm.programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = false;
    autocd = true; # If empty directory given as command, interpret it as cd

    sessionVariables.EDITOR = config.baseVars.editor;
    shellAliases.src = ". ~/.zshrc";

    history =
    {
      path = "${config.hostVars.homeDirectory}/.zsh_history";

      size = 100000;
      save = 100000;

      share = true; # Share history between terminal sessions
      ignoreDups = true; # # Ignore duplicates only if they're right next to each other
      expireDuplicatesFirst = true;
    };

    initExtra =
    ''
      source ${./options.sh}
      source ${./keybinds.sh}
    '';
  };
}
