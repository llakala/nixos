{ pkgs }: let
  inherit (pkgs) callPackage;
in {
  mkUnfreeNixpkgs = callPackage ./mkUnfreeNixpkgs.nix {};
  mkPackageSet = callPackage ./mkPackageSet.nix {};
  resolveAndFilter = callPackage ./resolveAndFilter.nix {};
  writeFishApplication = callPackage ./writeFishApplication.nix {};
}
