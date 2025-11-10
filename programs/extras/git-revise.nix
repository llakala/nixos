{ pkgs, config, ... }:

{
  # Better git rebase, according to people smarter than me
  environment.systemPackages = [ pkgs.git-revise ];

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    grv = "git revise";
    grvm = "git revise main";
    grvma = "git revise master";

    grvum = "git revise upstream/main";
    grvuma = "git revise upstream/master";

    # `grvi 2` will revise from last 2 commits
    grvi = {
      setCursor = true;
      expansion = "git revise -i HEAD~%";
    };
  };
}
