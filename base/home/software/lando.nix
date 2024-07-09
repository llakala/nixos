{ hostVars, ... }:

{

  # Follow this for install https://docs.lando.dev/install/source.html
  programs.bash.shellAliases =
  {
    lando = "perl ${hostVars.homeDirectory}/cli/bin/lando"; # Use lando command
  };

}