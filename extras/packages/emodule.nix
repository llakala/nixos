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

  text = # NOTE: doesn't do `pkgs.pkgs` by default, follow the nix.dev tutorial to add it
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