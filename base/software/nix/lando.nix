{ hostVars, ... }:

{

  # Follow this for install https://docs.lando.dev/install/source.html
  programs.zsh.shellAliases =
  {
    lando = "perl ${hostVars.homeDirectory}/cli/bin/lando"; # Use lando command
  };

  networking.extraHosts =
  ''
    127.0.0.1 dataport.lndo.site
    ::1 dataport.lndo.site
  ''; # Modifies /etc/hosts

}