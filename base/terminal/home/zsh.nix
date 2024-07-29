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
    source ${./zshextras/options.zsh}
    source ${./zshextras/keybinds.zsh}
    source ${./zshextras/rbld.zsh}
  '';
}
