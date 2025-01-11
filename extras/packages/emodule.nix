{ pkgs }:

pkgs.writeShellApplication
{
  name = "emodule"; # Evaluate a given module using `evalModules`

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
    nix eval --impure --json --expr \
    "
      let
        pkgs = import <nixpkgs> {};
        result = pkgs.lib.evalModules
        {
          modules = [ ./$FILE ];
        };
      in
        result.config
    " | jq
  '';
}