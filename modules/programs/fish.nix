{ self, pkgs, ... }:

{
  programs.command-not-found.enable = false;

  users.defaultUserShell = pkgs.fish; # TODO: use wrapper for this

  programs.fish = {
    enable = true;
    package = self.wrappers.fish.result;
    useBabelfish = true; # Important: halves the startup time
  };
}
