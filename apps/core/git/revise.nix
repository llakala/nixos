{ pkgs, lib, config, ... }:

{
  # Better git rebase, according to people smarter than me
  environment.systemPackages = lib.singleton pkgs.git-revise;

  hm.programs.fish.shellAbbrs =

  # Error if we ever change shell
  assert config.features.abbreviations == "fish";
  {
    grv = "git revise";
    grvm = "git revise main";
    grvma = "git revise master";

    grvum = "git revise upstream/main";
    grvuma = "git revise upstream/master";

    # `grvi 2` will revise from last 2 commits
    grvi =
    {
      setCursor = true;
      expansion = "git revise -i HEAD~%";
    };
  };
}
