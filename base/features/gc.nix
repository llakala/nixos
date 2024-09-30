{ lib, ... }:

{
  nix.optimise = # Runs `nix-store --optimise` on a timer. Used instead of auto-optimize-store so we don't need to do this on every build
  {
    automatic = true;
    dates = lib.singleton "daily";
  };

  nix.gc = # Runs `nix-collect-garbage` on a timer
  {
    automatic = true;
    persistent = true; # If system is powered off when timer finishes, do it next time the system power on
    dates = "daily";
    options = "--delete-older-than 14d"; # Delete old generations
  };
}