{ pkgs, hostVars, sources, config, ... }:

let
  npins = pkgs.callPackage (sources.npins + "/npins.nix") {};
in {
  environment.systemPackages = [ npins ];
  environment.variables.NPINS_DIRECTORY = "${hostVars.configDirectory}/various/npins";

  programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    npu = "npins update";
  };
}
