{
  config,
  pkgs,
  ...
}:

{
  programs.zsh.enable = true; # Required to set environment.shells
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  hm.programs.zsh =
  {
    enable = true;

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autocd = true; # If empty directory given as command, interpret it as cd
    shellAliases.src = ". ~/.zshrc";

    initExtra = # bash
    ''
      source ${./options.sh}
      source ${./keybinds.sh}

      function zle_ls
      {
        kitty @ ls -m recent:0 > /tmp/kittyTabCache.json
        cat /tmp/kittyTabCache.json | python3 ./kitty-convert-dump.py > $HOME/.config/kitty/kitty-session.kitty

        zle reset-prompt; zle redisplay
      }

      zle -N zle_ls
      bindkey "^O" zle_ls
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
}
