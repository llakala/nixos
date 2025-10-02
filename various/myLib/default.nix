{ pkgs }: let
  inherit (pkgs) callPackage;
in {
  mkUnfreeNixpkgs = callPackage ./mkUnfreeNixpkgs.nix {};
  mkPackageSet = callPackage ./mkPackageSet.nix {};
  recursivelyImport = callPackage ./recursivelyImport.nix {};
  writeFishApplication = callPackage ./writeFishApplication.nix {};
}
