{ inputs, pkgs, config, ... }:

{
  environment.systemPackages = with inputs.rebuild-but-less-dumb.packages.${pkgs.system};
  [
    rbld
    unify
  ];

  environment.variables = # Overriding default values so we don't have to pass `-d` and `-i` every time
  {
    FLAKE = config.baseVars.configDirectory;
    INPUTS_TRIGGERING_REBUILD = "nixpkgs nixpkgs-unstable home-manager rebuild-but-less-dumb"; # List of flake inputs, separated by spaces
  };
}
