{ inputs, lib, pkgs, ... }:

let
  package = inputs.git-repo-manager.packages.${pkgs.system}.default;
in
{
  environment.systemPackages = lib.singleton package;
}
