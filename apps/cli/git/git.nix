{ config, pkgs-unstable, lib, ... }:

{
  hm.programs.git =
  {
    enable = true;
    package = pkgs-unstable.gitFull;
    userName = config.baseVars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email

    diff-so-fancy =
    {
      enable = true;
      pagerOpts = lib.splitString # Go from space-separated string to list
        " "
        config.programs.less.envVariables.LESS; # Reuse the global less options
    };
  };

  environment.systemPackages = with pkgs-unstable;
  [
    git-extras
  ];
}
