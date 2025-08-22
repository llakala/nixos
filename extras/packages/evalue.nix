{ pkgs, llakaLib }:

llakaLib.writeFishApplication {
  name = "evalue"; # Evaluate a given nix file using `callPackage`

  runtimeInputs = with pkgs; [
    jq
  ];

  text =
  /* fish */
  ''

    switch (count $argv)
      case 0
        echo "A file needs to be passed!"
        exit 1

      case 1
        set FILE $argv[1]

      case 2
        set FILE $argv[1]
        set ARG $argv[2]

      case '*'
        echo "Too many arguments! Only 1 or 2 are expected"
        exit 1
    end

    nix eval --impure --expr "let pkgs = import <nixpkgs> { }; in (pkgs.callPackage $FILE { }) $ARG"
  '';
}
