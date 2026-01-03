{ adios }:
let
  inherit (adios) types;
in {
  name = "fzf";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  # Rather than injecting this into an actual wrapper, I recommend reading from
  # args.options of the fzf wrapper, and setting these in a nixpkgs context.
  options = {
    defaultOpts = {
      type = types.string;
    };
    shellIntegration = {
      type = types.struct "shellIntegration" {
        ctrl-r = types.struct "ctrl-r" {
          opts = types.string;
        };
        alt-c = types.struct "alt-c" {
          opts = types.string;
          command = types.string;
        };
      };
    };
  };

  mutations."/fish".interactiveShellInit =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs lib;
    in
    # fish
    ''
      ${lib.getExe pkgs.fzf} --fish | source
    '';
}
