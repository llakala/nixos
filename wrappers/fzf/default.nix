{ adios }:
let
  inherit (adios) types;
in {
  name = "fzf";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    zoxide.path = "/zoxide";
  };

  # Rather than injecting this into an actual wrapper, I recommend reading from
  # args.options of the fzf wrapper, and setting these in a nixpkgs context.
  # TODO: see if I can avoid this
  options = {
    defaultOpts = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./FZF_OPTS;
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
      defaultFunc =
        { inputs }:
        let
          inherit (inputs.nixpkgs) lib;
          zoxideWrapper = inputs.zoxide {};
        in {
          ctrl-r.opts = lib.fileContents ./CTRL_R_OPTS;
          alt-c = {
            command = "${lib.getExe zoxideWrapper} query --list --score";
            opts = lib.fileContents ./ALT_C_OPTS;
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
