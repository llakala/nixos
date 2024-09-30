{ ... }:

{
  nix.optimise.automatic = true; # Used instead of auto-optimize-store so that `nix-store --optimise` runs daily rather than for every build

  boot.loader.systemd-boot.configurationLimit = 20; # Only keep last 20 generations

  nix.gc =
  {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}