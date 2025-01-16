{ pkgs, llakaLib }:

llakaLib.writeFishApplication
{
  name = "evalue"; # Evaluate a given nix file, with all the `callPackage` privileges we like

  runtimeInputs = with pkgs;
  [
    jq
  ];

  text = # The way I do this with --impure feels hacky, but I don't know anything better
  /* fish */
  ''
    set FILE $argv[1]
    nix eval --impure --json --expr "with import <nixpkgs> { }; callPackage ./$FILE { }" | jq
  '';
}