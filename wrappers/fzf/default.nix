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
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./FZF_DEFAULT_OPTS;
    };

    ctrl-r = {
      type = types.struct "ctrl-r" {
        opts = types.string;
      };
      defaultFunc =
        { inputs }:
        {
          opts = inputs.nixpkgs.lib.fileContents ./FZF_CTRL_R_OPTS;
        };
    };

    alt-c = {
      type = types.struct "alt-c" {
        opts = types.string;
        command = types.string;
      };
      defaultFunc =
        { inputs }:
        let
          inherit (inputs.nixpkgs) lib;
          zoxideWrapper = inputs.zoxide {};
        in
        {
          command = "${lib.getExe zoxideWrapper} query --list --score";
          opts = lib.fileContents ./FZF_ALT_C_OPTS;
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
