{ lib, inputs, llakaLib, ... }:

{
  nix.registry = lib.mkForce
  {
    nixpkgs.flake = inputs.nixpkgs;

    # Allow running unfree packages with nix3 commands via `nix run unfree#steam`
    unfree.flake = llakaLib.mkUnfreeNixpkgs { path = inputs.nixpkgs; };
  };
}
