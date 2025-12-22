{ self, pkgs, ... }:

{
  features.shell = "fish"; # If we ever stop using Fish, change this
  features.abbreviations = "fish";

  programs.command-not-found.enable = false;

  users.defaultUserShell = pkgs.fish; # TODO: use wrapper for this

  programs.fish = {
    enable = true;
    package = self.wrappers.fish.drv;
    useBabelfish = true; # Important: halves the startup time
  };
}
