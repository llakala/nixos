{ lib, pkgs, hostVars, sources, config, ... }:

let
  npins = pkgs.callPackage (sources.npins + "/npins.nix") {};
in {
  environment.systemPackages = lib.singleton npins;
  environment.variables.NPINS_DIRECTORY = "${hostVars.configDirectory}/various/npins";

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    npu = "npins update";
  };
}
