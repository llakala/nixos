{ pkgs }: let
  inherit (pkgs) callPackage;
in {
  recursivelyImport = callPackage ./recursivelyImport.nix {};
  writeFishApplication = callPackage ./writeFishApplication.nix {};
  recursiveUpdate = import ./recursiveUpdate.nix;
}
