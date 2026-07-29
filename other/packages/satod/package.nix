{ wrappers, localPackages, myLib, fzf }:

myLib.writeFishApplication {
  name = "satod"; # Split a Type of Diff

  runtimeInputs = builtins.attrValues {
    inherit fzf;
    inherit (localPackages) gps;
    git = wrappers.git.drv;
    diff-so-fancy = wrappers.diff-so-fancy.drv;
  };

  text = builtins.readFile ./satod.fish;
}
