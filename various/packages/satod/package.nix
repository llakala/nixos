{ wrappers, localPackages, myLib }:

myLib.writeFishApplication {
  name = "satod"; # Split a Type of Diff

  runtimeInputs = builtins.attrValues {
    inherit (localPackages) splitpatch;
    fzf = wrappers.fzf.drv;
    git = wrappers.git.drv;
    diff-so-fancy = wrappers.diff-so-fancy.drv;
  };

  text = builtins.readFile ./satod.fish;
}
