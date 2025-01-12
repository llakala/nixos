{ writeShellApplication, pkgs }:

writeShellApplication
{
  name = "efunc"; # Evaluate a file containing a nix function, sending the function your given argument

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

  text =
  /* bash */
  ''
    FILE=$1
    ARG=$2
    nix eval --impure --json --expr "with import <nixpkgs> { }; (callPackage ./$FILE { }) $ARG" | jq
  '';
}