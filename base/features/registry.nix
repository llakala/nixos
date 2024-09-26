{ lib, pkgs, inputs, myLib, ... }:


{
  nix.registry = lib.mkForce # Makes `nix run` commands use unfree
  {
    nixpkgs.flake = pkgs.callPackage myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs; };
    nixpkgs-unstable.flake = pkgs.callPackage myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs-unstable; };
  };
}