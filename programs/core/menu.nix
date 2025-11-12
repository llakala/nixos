{ sources, pkgs, config, hostVars, ... }:

let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
in {
  environment.systemPackages = with menu; [
    rbld
    unify
    fuiska
    imanpu
  ];

  # Overriding default values so we don't have to pass our arguments every time
  environment.variables = {
    RBLD_DIRECTORY = hostVars.configDirectory;
    UNIFY_DIRECTORY = hostVars.configDirectory;

    UNIFY_TRACKED_INPUTS = "nixpkgs home-manager menu gasp meovim";
    UNIFY_COMMIT_MESSAGE = "flake: update flake.lock";
    UNIFY_PRIMARY_BRANCHES = "main master";

    IMANPU_DIRECTORY = "${hostVars.configDirectory}/various/npins";
  };

  programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    fsk = "fuiska";
    r = "rbld";
    imp = "imanpu";
  };

}
