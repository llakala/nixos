{ lib, pkgs, self, ... }:

{
  environment.systemPackages = lib.singleton pkgs.diff-so-fancy;

  hm.programs.git.iniContent = {
    interactive.diffFilter = "diff-so-fancy --patch";

    pager.diff = "diff-so-fancy | ${lib.getExe self.wrappers.less.drv}";

    diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`
  };
}
