{ lib, pkgs }:

{ extras ? {}, filepaths }: let
  callPackage = lib.callPackageWith (pkgs // extras // { localPackages = packages; });
  packages = builtins.mapAttrs
    (_: path: callPackage path {})
    filepaths;
in packages
