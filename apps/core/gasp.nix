{ inputs, pkgs, config, ... }:

{
  environment.systemPackages = with inputs.gasp.legacyPackages.${pkgs.system};
  [
    ghp # Git Hire Patch (stage)
    gfp # Git Fire Patch (unstage)
    gkp # Git Kill Patch (reset)

    splitpatch
  ];


  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    hp = "ghp";
    fp = "gfp";
    kp = "gkp";
  };
}
