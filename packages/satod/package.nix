{ wrappers, localPackages, myLib, fzf }:

myLib.writeFishApplication {
  name = "satod"; # Split a Type of Diff

  runtimeInputs = builtins.attrValues {
    inherit fzf;
    inherit (localPackages) gps;
    git = wrappers.git.result;
    diff-so-fancy = wrappers.diff-so-fancy.result;
  };

  text = builtins.readFile ./satod.fish;
}
