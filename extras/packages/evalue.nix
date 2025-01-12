{ writeShellApplication, pkgs }:

writeShellApplication
{
  name = "evalue"; # Evaluate a given nix file, with all the `callPackage` privileges we like

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  runtimeInputs = with pkgs;
  [
    jq
  ];

  text = # The way I do this with --impure feels hacky, but I don't know anything better
  /* bash */
  ''
    FILE=$1
    nix eval --impure --json --expr "with import <nixpkgs> { }; callPackage ./$FILE { }" | jq
  '';
}