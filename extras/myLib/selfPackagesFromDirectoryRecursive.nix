{ lib, ... }:

# From https://noogle.dev/f/lib/packagesFromDirectoryRecursive#create-a-scope-for-the-nix-files-found-in-a-directory
# For convenience in flake with custom packages relying on each other
let
  selfPackagesFromDirectoryRecursive = { directory, pkgs }:
  lib.makeScope pkgs.newScope
  (
    self: lib.packagesFromDirectoryRecursive
    {
      inherit (self) callPackage;
      inherit directory;
    }
  );
in
  selfPackagesFromDirectoryRecursive