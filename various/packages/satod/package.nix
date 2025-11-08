{ git, fzf, localPackages, myLib }:

myLib.writeFishApplication {
  name = "satod"; # Split a Type of Diff

  runtimeInputs = builtins.attrValues {
    # TODO: use my diff-so-fancy wrapper as a dependency, rather than assuming
    # it to be in $PATH
    inherit fzf git;
    inherit (localPackages) splitpatch;
  };

  text = builtins.readFile ./satod.fish;
}
