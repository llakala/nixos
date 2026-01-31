{ pkgs, self, ... }:

{
  environment.systemPackages = [ pkgs.npins ];
  environment.variables.NPINS_DIRECTORY = "${self.hostVars.configDirectory}/various/npins";
}
