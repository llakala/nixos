{ ... }:

{
  nix.optimise.automatic = true; # Used instead of auto-optimize-store so that `nix-store --optimise` runs daily rather than for every build



  nix.gc =
  {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}