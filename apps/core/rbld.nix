{ inputs, pkgs, config, ... }:

{
  environment.systemPackages = with inputs.rebuild-but-less-dumb.packages.${pkgs.system};
  [
    rbld
    unify
    fuiska
  ];

  environment.variables = # Overriding default values so we don't have to pass our arguments every time
  {
    RBLD_DIRECTORY = config.baseVars.configDirectory;
    UNIFY_DIRECTORY = config.baseVars.configDirectory;

    UNIFY_TRACKED_INPUTS = "nixpkgs nixpkgs-unstable home-manager rebuild-but-less-dumb gasp";
    UNIFY_COMMIT_MESSAGE = "flake: update flake.lock";
    UNIFY_PRIMARY_BRANCHES = "main master";
  };
}
