{ lib, ... }:

{
  # Finds identical files and deduplicates them. Just `nix-store --optimise` on a timer.
  nix.optimise = 
  {
    automatic = true;
    dates = lib.singleton "daily"; # Only runs daily, preferred over auto-optimise-store, which runs every rebuild and makes rebuilds take longer.
  };

  nix.gc = # Deletes old stuff from the store that's now unreachable. Just `nix-collect-garbage` / `nix-store --gc`) on a timer.
  {
    automatic = true;
    persistent = true; # If system is powered off when timer finishes, do it next time the system power on
    dates = "daily";
    options = "--delete-older-than 14d"; # Delete old generations
  };
}
