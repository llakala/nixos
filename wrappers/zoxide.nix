_:
{
  options = {
    # I have Yazi set up to auto-update the zoxide database based on where I go --
    # and neovim integration into Zoxide. However, this means that if i have a repo
    # called `reponame`, and a subdirectory `reponame/src/reponame`, the one under
    # src gets higher precedence. This isn't what we want! To get around this, we
    # filter out subdirs of `src`, so we don't open the wrong directory.
    excludedDirs.default = "**/src/**";
  };
}
