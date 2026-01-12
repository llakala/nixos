{
  sources ? import ./various/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ./various/myLib/default.nix { inherit pkgs; }
}:

let
  inherit (pkgs) lib;
  callPackage = lib.callPackageWith (pkgs // { inherit myLib; localPackages = packages; });
  packages = {
    emodule = callPackage ./various/packages/emodule.nix {};
    evalue = callPackage ./various/packages/evalue.nix {};
    git-repo-manager = callPackage ./various/packages/git-repo-manager.nix {};
    satod = callPackage ./various/packages/satod/package.nix {};
    mathematica = callPackage ./various/packages/mathematica.nix {};
    splitpatch = callPackage ./various/packages/splitpatch.nix {};
  };
in packages
