{ myLib, pkgs }:

myLib.writeFishApplication
{
  name = "efunc"; # Evaluate a file containing a nix function, sending the function your given argument

  runtimeInputs = with pkgs;
  [
    jq
  ];

  text =
  /* fish */
  ''
    set FILE $argv[1]
    set ARG $argv[2]
    nix eval --impure --json --expr "with import <nixpkgs> { }; (callPackage ./$FILE { }) $ARG" | jq
  '';
}