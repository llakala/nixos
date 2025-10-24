{ lib, config, pkgs, ... }:

let
  globalLessOpts = config.programs.less.envVariables.LESS;
in {
  environment.systemPackages = lib.singleton pkgs.diff-so-fancy;

  hm.programs.git.iniContent = {
    interactive.diffFilter = "diff-so-fancy --patch";

    pager.diff = "diff-so-fancy | less ${globalLessOpts}";

    diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`
  };
}
