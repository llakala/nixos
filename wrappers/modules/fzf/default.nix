{ adios }:
let
  inherit (adios) types;
in {
  name = "fzf";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    zoxide.path = "/zoxide";
  };

  options = {
    defaultOpts = {
      type = types.string;
    };
    shellIntegration = {
      type = types.struct "shellIntegration" {
        ctrlR = types.struct "ctrl-r" {
          opts = types.string;
        };
        altC = types.struct "alt-c" {
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
