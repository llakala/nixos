{ lib, pkgs, inputs, myLib, ... }:


{
  nix.registry = lib.mkForce
  {
    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;

    # Allow running unfree packages with nix3 commands via `nix run unfree#steam`
    unfree.flake = pkgs.callPackage myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs; };
    unfree-unstable.flake = pkgs.callPackage myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs-unstable; };
  };
}
