{
  sources ? import ./other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ./other/myLib/default.nix { inherit pkgs; },
  wrappers ? import ./wrappers.nix { inherit pkgs sources myLib; }
}:

let
  inherit (pkgs) lib;
  callPackage = lib.callPackageWith (
    pkgs
    // {
      inherit myLib wrappers;
      localPackages = packages;
    }
  );
  packages = {
    emodule = callPackage ./other/packages/emodule.nix {};
    evalue = callPackage ./other/packages/evalue.nix {};
    satod = callPackage ./other/packages/satod/package.nix {};
    mathematica = callPackage ./other/packages/mathematica.nix {};
    splitpatch = callPackage ./other/packages/splitpatch.nix {};
  };
in packages
