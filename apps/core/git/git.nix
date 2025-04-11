{ config, pkgs-unstable, ... }:

{
  hm.programs.git =
  {
    enable = true;
    package = pkgs-unstable.gitFull;

    # Full name associated with commits
    userName = config.baseVars.fullName;

    # github noreply email
    userEmail = "78693624+quatquatt@users.noreply.github.com";
  };

  environment.systemPackages = with pkgs-unstable;
  [
    git-extras

    # cool git interface
    tig
  ];
}
