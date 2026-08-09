{ localPackages, myLib }:

myLib.writeFishApplication {
  name = "sadin"; # Split a Diff in Neovim

  runtimeInputs = [
    localPackages.gps
  ];
  text = builtins.readFile ./sadin.fish;
}
