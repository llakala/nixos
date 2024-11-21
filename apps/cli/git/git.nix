{ config, pkgs-unstable, lib, inputs, ... }:

{
  hm = # Use unstable home-manager module since it adds new options
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/git.nix";
    imports = lib.singleton "${inputs.home-manager-unstable}/modules/programs/git.nix";
  };

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
}
