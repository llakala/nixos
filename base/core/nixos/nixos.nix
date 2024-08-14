{
  hostVars,
  pkgs,
  pkgs-unstable,
  inputs,
  lib,
  vars,
  ...
}:

{
  nix.package = pkgs-unstable.nixVersions.latest; # Use latest version of nix package manager

  nix.settings =
  {
    max-jobs = lib.mkDefault 4;
    experimental-features = "nix-command flakes";

    nix-path =
    [
      "nixpkgs=${pkgs.path}"
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
  };


  systemd.services.nix-daemon.environment.TMPDIR = "/nix/tmp"; # TMPFS is too small for building some stuff


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}