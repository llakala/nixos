{ lib, config, pkgs, ... }:

{
  environment.systemPackages = lib.singleton pkgs.diff-so-fancy;

  hm.programs.git.iniContent = {
    interactive.diffFilter = "diff-so-fancy --patch";

    # Auto-select the start of each diffed file, so `n` and `N` will go between them
    pager.diff = "diff-so-fancy | less ${config.custom.lessConfig} --pattern '^(Date|added|deleted|modified|renamed):'";

    diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`
  };
}
