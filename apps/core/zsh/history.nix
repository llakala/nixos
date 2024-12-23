{ config, ... }:

{
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