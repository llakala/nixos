{ pkgs, ... }:

{
  mdpls = pkgs.callPackage ./mdpls.nix { };
  splitpatch = pkgs.callPackage ./splitpatch.nix { };
  colo = pkgs.callPackage ./colo.nix { };
}
