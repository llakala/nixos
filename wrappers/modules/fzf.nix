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
  # TODO: see if I can avoid this
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
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.fzf;
    };
  };

  mutations."/fish".interactiveShellInit =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) lib;
    in
    # fish
    ''
      ${lib.getExe options.package} --fish | source
    '';
}
