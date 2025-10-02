{ myLib, pkgs }:

myLib.writeFishApplication {
  name = "emodule"; # Evaluate a given module using `evalModules`

  runtimeInputs = with pkgs; [
    jq
  ];

  # NOTE: doesn't do `pkgs.pkgs` by default, follow the nix.dev tutorial to add it
  text = # fish
  ''
    set FILE $argv[1]
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
