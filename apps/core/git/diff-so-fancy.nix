{ lib, config, ... }:
let
  globalLessOpts = config.programs.less.envVariables.LESS;
in
{
  hm.programs.git.diff-so-fancy =
  {
    enable = true;
    markEmptyLines = false; # So nothing else looks like `red reverse`

    # Convert from space-separated string to list of strings
    pagerOpts = lib.splitString " " globalLessOpts;
  };

  hm.programs.git.iniContent =
  {
    # Auto-select the start of each diffed file, so `n` and `N` will go between them
    pager.diff = "diff-so-fancy | less ${globalLessOpts} --pattern '^(Date|added|deleted|modified):'";
  };
}