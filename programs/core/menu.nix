{ sources, pkgs, config, hostVars, ... }:

let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
in {
  environment.systemPackages = with menu; [
    fuiska
    imanpu
  ];

  # Overriding default values so we don't have to pass our arguments every time
  environment.variables = {
    UNIFY_DIRECTORY = hostVars.configDirectory; # Also used by fuiska
    IMANPU_DIRECTORY = "${hostVars.configDirectory}/various/npins";
  };

  programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    fsk = "fuiska";
    imp = "imanpu";
  };

}
