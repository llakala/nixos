{ config, inputs, lib, ... }:

{
  # Not 2.92 yet, see https://github.com/NixOS/nixpkgs/pull/375030
  imports = lib.singleton inputs.lix-module.nixosModules.lixFromNixpkgs;

  nix.settings =
  {
    experimental-features =
    [
      "nix-command"
      "flakes"
      "no-url-literals"

      # Lix experimental features
      "repl-flake" # Nix has merged this since 2.18, Lix hasn't yet
    ];

    substituters =
    [
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys =
    [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    connect-timeout = 5; # Offline caches won't just hang
    warn-dirty = false; # No warnings if git isn't pushed
    fallback = true; # If binary cache fails, it's okay

    keep-going = true; # If a derivation fails, build the others. We'll fix the failed one later
    max-jobs = "auto";

    allow-import-from-derivation = false;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nixpkgs.config.allowUnfree = true; # for `pkgs` instance, `pkgs-unstable` gets it on creation

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = config.hostVars.stateVersion;
}
