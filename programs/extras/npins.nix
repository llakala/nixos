{ lib, pkgs, hostVars, ... }:
{
  environment.systemPackages = lib.singleton pkgs.npins;
  environment.variables.NPINS_DIRECTORY = "${hostVars.configDirectory}/various/npins";
}
