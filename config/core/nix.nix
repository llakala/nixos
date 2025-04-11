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

      # Nix has merged this since 2.18, Lix hasn't yet
      "repl-flake"
    ];

    substituters =
    [
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys =
    [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users =
    [
      "root"

      # Lets me use nix flakes that require nixConfig.
      "@wheel"
    ];

    # Offline caches won't just hang
    connect-timeout = 5;

    # No warnings if git isn't pushed
    warn-dirty = false;

    # If binary cache fails, it's okay
    fallback = true;

    # If a derivation fails, build the others. We'll fix the failed one later
    keep-going = true;
    max-jobs = "auto";

    allow-import-from-derivation = false;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # for `pkgs` instance, `pkgs-unstable` gets it on creation
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = config.hostVars.stateVersion;
}
