{ config, pkgs, lib, ... }:

{
  programs.zsh.enable = true; # Required to set environment.shells
  environment.shells = lib.singleton pkgs.zsh;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = lib.singleton "/share/zsh";

  hm.programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    enableCompletion = true;

    autocd = true; # If empty directory given as command, interpret it as cd
    shellAliases.zsrc = "source ~/.zshrc && exec zsh";

    completionInit = ""; # Removes useless line from zshrc

    initExtra =
    /* bash */
    ''
      source ${./options.sh}
      source ${./keybinds.sh}
    '';
  };


  hm.programs.zsh.history = 
  {
    path = "${config.hostVars.homeDirectory}/.zsh_history";

    size = 100000;
    save = 100000;

    share = true; # Share history between terminal sessions
    ignoreDups = true; # # Ignore duplicates only if they're right next to each other
    expireDuplicatesFirst = true;
  };

  hm.programs.zsh.plugins =
  [
    {
      name = "zsh-fast-syntax-highlighting";
      src = pkgs.zsh-fast-syntax-highlighting;
      file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
    }

    {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
    }

  ];

}
