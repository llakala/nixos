{ self, ... }:

let
  inputs = self.inputs;
  nixpkgs = self.inputs.nixpkgs; # When possible, we only propagate nixpkgs instead of passing all inputs
  lib = nixpkgs.lib;

  myLib = (import ./default.nix) {inherit self;}; # Pass around so functions in different files can call each other

  internals = # Helpful internal abstractions for different parts of a function, but we should only give the user the wrapping function
  {
    resolveFolders = import ./resolveFolders.nix { inherit lib myLib; };
    filterNixFiles = import ./filterNixFiles.nix { inherit lib myLib; };
  };
in
{
  resolveAndFilter = input: internals.filterNixFiles ( internals.resolveFolders input ); # filter *after* resolving. Otherwise, we'll have subfolders with unfiltered files

  mkNixos = import ./mkNixos.nix { inherit lib myLib inputs self; };
  mkHome = import ./mkHome.nix { inherit lib myLib; };

  mkList = attrset: [ attrset ];

  mkUnfreeNixpkgs = import ./mkUnfreeNixpkgs.nix; # Don't send function args because they're passed at use-time

  forAllSystems = import ./forAllSystems.nix { inherit lib myLib nixpkgs; };

  mkPkgs = import ./mkPkgs.nix;
  selfPackagesFromDirectoryRecursive = import ./selfPackagesFromDirectoryRecursive.nix { inherit lib; };
}
