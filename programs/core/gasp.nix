{ sources, pkgs, config, ... }:

let
  gasp = import "${sources.gasp}/packages/default.nix" { inherit pkgs; };
in {
  environment.systemPackages = with gasp; [
    satod
  ];

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    h = "satod hire";
    f = "satod fire";
    k = "satod kill";
  };
}
