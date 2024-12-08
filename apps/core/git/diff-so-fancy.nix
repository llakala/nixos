{ lib, config, ... }:

{
  hm.programs.git.diff-so-fancy =
  {
    enable = true;
    pagerOpts = lib.splitString # Go from space-separated string to list
      " "
      config.programs.less.envVariables.LESS; # Reuse the global less options
    markEmptyLines = false; # So nothing else looks like `red reverse`
  };
}