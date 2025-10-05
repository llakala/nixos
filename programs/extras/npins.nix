{ lib, pkgs, hostVars, sources, ... }:

let
  npins = pkgs.callPackage (sources.npins + "/npins.nix") {};
in {
  environment.systemPackages = lib.singleton npins;
  environment.variables.NPINS_DIRECTORY = "${hostVars.configDirectory}/various/npins";
}
