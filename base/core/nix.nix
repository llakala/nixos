{ config, inputs, pkgs-unstable, ... }:

{
  nix.package = pkgs-unstable.nixVersions.latest;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nix.settings =
  {
    experimental-features = "nix-command flakes";

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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = config.hostVars.stateVersion;
}
