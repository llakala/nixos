{ lib, ... }:

{
  # Finds identical files and deduplicates them. Just `nix-store --optimise` on a timer.
  nix.optimise =
  {
    automatic = true;

    # Only runs daily, preferred over auto-optimise-store, which runs every rebuild and makes rebuilds take longer.
    dates = lib.singleton "daily";
  };

  # Deletes old stuff from the store that's now unreachable.
  # Just `nix-collect-garbage` / `nix-store --gc`) on a timer.
  nix.gc =
  {
    automatic = true;

    # If system is powered off when timer finishes, do it next time the system power on
    persistent = true;
    dates = "daily";

    # Delete old generations
    options = "--delete-older-than 7d";
  };
}
