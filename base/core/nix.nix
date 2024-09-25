{
  hostVars,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:

{
  nix.package = pkgs-unstable.nixVersions.latest;

  nix.registry =
  {
    nixpkgs.flake = inputs.nixpkgs; # Apparently makes evaluation of `nix search` faster
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable; # Lets us access nixpkgs-unstable via `nix run`
  };

  nix.settings =
  {
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


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  documentation.nixos.enable = false; # Apparently speeds up rebuild time

  system.stateVersion = hostVars.stateVersion;
}