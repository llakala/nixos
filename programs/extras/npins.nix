{ pkgs, hostVars, ... }:

{
  environment.systemPackages = [ pkgs.npins ];
  environment.variables.NPINS_DIRECTORY = "${hostVars.configDirectory}/various/npins";
}
