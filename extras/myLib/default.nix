{ self, ... }:

let
  inputs = self.inputs;
  lib = inputs.nixpkgs.lib;

  myLib = (import ./default.nix) {inherit self;}; # Pass around so functions in different files can call each other

in
{
  mkNixos = import ./mkNixos.nix { inherit lib myLib inputs self; };
  mkHome = import ./mkHome.nix { inherit lib myLib; };

  mkUnfreeNixpkgs = import ./mkUnfreeNixpkgs.nix; # Don't send function args because they're passed at use-time

  forAllSystems = import ./forAllSystems.nix { inherit lib myLib inputs; };

  resolveFolders = import ./resolveFolders.nix { inherit lib myLib; };
  filterNixFiles = import ./filterNixFiles.nix { inherit lib myLib; };
  resolveAndFilter = import ./resolveAndFilter.nix { inherit lib myLib; };

  mkPkgs = import ./mkPkgs.nix { };
  selfPackagesFromDirectoryRecursive = import ./selfPackagesFromDirectoryRecursive.nix { inherit lib; };
}
