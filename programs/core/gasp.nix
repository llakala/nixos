{ sources, pkgs, config, ... }:

let
  gasp = import "${sources.gasp}/packages/default.nix" { inherit pkgs; };
in {
  environment.systemPackages = with gasp; [
    ghp # Git Hire Patch (stage)
    gfp # Git Fire Patch (unstage)
    gkp # Git Kill Patch (reset)

    splitpatch
  ];

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    h = "ghp";
    f = "gfp";
    k = "gkp";
  };
}
