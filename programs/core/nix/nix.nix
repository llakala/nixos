{ hostVars, pkgs, ... }:

{
  nix.package = pkgs.lixPackageSets.latest.lix;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "no-url-literals"
    ];

    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "root"
      "@wheel" # Lets me use nix flakes that require nixConfig.
    ];

    connect-timeout = 5; # Offline caches won't just hang
    warn-dirty = false; # No warnings if git isn't pushed
    fallback = true; # If binary cache fails, it's okay

    keep-going = true; # If a derivation fails, build the others. We'll fix the failed one later
    max-jobs = "auto";

    allow-import-from-derivation = false;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = hostVars.stateVersion;
}
