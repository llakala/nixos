{ hostVars, ... }:

{

  programs.bash.shellAliases =
  {
    lando = "perl ${hostVars.homeDirectory}/cli/bin/lando"; # Use lando command
  };

}