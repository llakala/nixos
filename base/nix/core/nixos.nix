{
  hostVars,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  nix =
  {
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
  };

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}"; # https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry

  nix.settings =
  {
    nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    experimental-features = "nix-command flakes";

    auto-optimise-store = true;
    connect-timeout = 5;
    log-lines = 25; # Show more lines if error happens
    warn-dirty = false; # No warnings if git isn't pushed
  };

  system.activationScripts.diff =
  ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix store diff-closures /run/current-system "$systemConfig"
    fi
  ''; # Shows diff when rebuilding as described in https://github.com/NixOS/nixpkgs/pull/208902#pullrequestreview-1234947182


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}