{ pkgs, lib, ... }:

{
  programs.zsh.enable = true; # Required to set environment.shells
  environment.shells = lib.singleton pkgs.zsh;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = lib.singleton "/share/zsh";

  hm.programs.zsh =
  {
    enable = true;

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
}
