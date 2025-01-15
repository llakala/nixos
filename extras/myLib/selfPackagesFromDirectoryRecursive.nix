{ lib, myLib }:
# From https://noogle.dev/f/lib/packagesFromDirectoryRecursive#create-a-scope-for-the-nix-files-found-in-a-directory
# For convenience in flake with custom packages relying on each other
# We also let custom packages rely on myLib functions

let
  utils = { inherit myLib; };
in
{ directory, pkgs }: # Function arguments
lib.makeScope pkgs.newScope
(
  selfPkgs: lib.packagesFromDirectoryRecursive # selfPkgs are internally-defined packages we find along the way
  {
    callPackage = lib.callPackageWith (selfPkgs // pkgs // utils ); # Rely on custom packages, `pkgs`, and `myLib`
    inherit directory;
  }
)
