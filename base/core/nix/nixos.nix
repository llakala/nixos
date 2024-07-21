{
  hostVars,
  pkgs,
  inputs,
  lib,
  vars,
  ...
}:

{
  nix.settings.nix-path =
  [
    "nixpkgs=${pkgs.path}"
  ];

  nix.settings =
  {
    max-jobs = lib.mkDefault 4;
    experimental-features = "nix-command flakes";

    substituters =
    [
      "https://nix-community.cachix.org"
    ];
     trusted-public-keys =
    [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    auto-optimise-store = true;
    connect-timeout = 5;
    log-lines = 25; # Show more lines if error happens
    warn-dirty = false; # No warnings if git isn't pushed
  };


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}