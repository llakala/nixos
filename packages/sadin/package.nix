{ localPackages, writeShellApplication }:

writeShellApplication {
  name = "sadin"; # Split a Diff in Neovim

  runtimeInputs = [
    localPackages.gps
  ];
  text = builtins.readFile ./sadin.sh;
}
