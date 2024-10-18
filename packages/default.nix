{ pkgs, ... }:
{
  mdpls = pkgs.callPackage ./mdpls.nix { };
}
