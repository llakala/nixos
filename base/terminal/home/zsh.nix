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
    source ${./zshextras/rbld.sh}
  '';
}
