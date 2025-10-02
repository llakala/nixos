{ baseVars, pkgs, ... }:

{
  hm.programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = baseVars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email
  };

  environment.systemPackages = with pkgs; [
    tig # cool git interface
  ];
}
