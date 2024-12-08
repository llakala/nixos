{ config, pkgs-unstable, ... }:

{
  hm.programs.git =
  {
    enable = true;
    package = pkgs-unstable.gitFull;
    userName = config.baseVars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email
  };

  environment.systemPackages = with pkgs-unstable;
  [
    git-extras
    tig # cool git interface
  ];
}
