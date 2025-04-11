{ lib, pkgs-unstable, ... }:

{

  # run "zoxide" to see manpages, etc
  hm.programs.zoxide =
  {
    enable = true;
    package = pkgs-unstable.zoxide;

    # Give `cd` `z` functionality, `z` no longer does anything
    options = lib.singleton "--cmd cd";
  };

  # I have Yazi set up to auto-update the zoxide database based on where I go --
  # and neovim integration into Zoxide. However, this means that if i have a repo
  # called `reponame`, and a subdirectory `reponame/src/reponame`, the one under
  # src gets higher precedence. This isn't what we want! To get around this, we
  # filter out subdirs of `src`, so we don't open the wrong directory.
  environment.variables._ZO_EXCLUDE_DIRS = "*/src/*";

}
