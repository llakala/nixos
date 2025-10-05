{ hostVars, pkgs, sources, ... }:

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

    # Disable the global registry, which pins random flakes that eelco decided
    # should be first-class citizens for some reason
    flake-registry = "";

    connect-timeout = 5; # Offline caches won't just hang
    warn-dirty = false; # No warnings if git isn't pushed
    fallback = true; # If binary cache fails, it's okay

    keep-going = true; # If a derivation fails, build the others. We'll fix the failed one later
    max-jobs = "auto";

    allow-import-from-derivation = false;
  };

  # Keep nix registry synced with our pinned npins input
  nixpkgs.flake = {
    source = sources.nixpkgs;
    setNixPath = false;
    setFlakeRegistry = true;
  };

  # Keeps <nixpkgs> pinned to the current nixpkgs revision. Requires relog to
  # apply
  nix.nixPath = [
    "nixpkgs=${sources.nixpkgs.outPath}"
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}
