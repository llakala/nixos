{ self, pkgs, ... }:

{
  programs.command-not-found.enable = false;

  users.defaultUserShell = pkgs.fish; # TODO: use wrapper for this

  programs.fish = {
    enable = true;
    package = self.wrappers.fish.drv;
    useBabelfish = true; # Important: halves the startup time
  };
}
