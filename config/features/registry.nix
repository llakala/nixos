{ lib, pkgs, inputs, myLib, ... }:

{
  nix.registry = lib.mkForce
  {
    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;

    # Allow running unfree packages with nix3 commands via `nix run unfree#steam`
    unfree.flake = myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs; };
    unfree-unstable.flake = myLib.mkUnfreeNixpkgs { path = inputs.nixpkgs-unstable; };
  };
}
