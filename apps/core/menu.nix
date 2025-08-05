{ inputs, pkgs, config, ... }:

{
  environment.systemPackages = with inputs.menu.legacyPackages.${pkgs.system};
  [
    rbld
    unify
    fuiska
  ];

  # Overriding default values so we don't have to pass our arguments every time
  environment.variables =
  {
    RBLD_DIRECTORY = config.hostVars.configDirectory;
    UNIFY_DIRECTORY = config.hostVars.configDirectory;

    UNIFY_TRACKED_INPUTS = "nixpkgs home-manager menu gasp meovim";
    UNIFY_COMMIT_MESSAGE = "flake: update flake.lock";
    UNIFY_PRIMARY_BRANCHES = "main master";
  };

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    fsk = "fuiska";
    r = "rbld";
  };

}
