{ sources ? import ./various/npins, pkgs ? import sources.nixpkgs {} }:

let
  inherit (pkgs) lib;
  myLib = import ./various/myLib/default.nix { inherit pkgs; };
  callPackage = lib.callPackageWith (pkgs // { inherit myLib; });
in {
  emodule = callPackage ./various/packages/emodule.nix {};
  evalue = callPackage ./various/packages/evalue.nix {};
  git-repo-manager = callPackage ./various/packages/git-repo-manager.nix {};
  jc = callPackage ./various/packages/jc.nix {};
  kittab = callPackage ./various/packages/kittab.nix {};
}
