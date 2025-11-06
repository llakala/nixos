{ adios }:
let
  inherit (adios) types;
in
{
  name = "fzf";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    zoxide.path = "/zoxide";
  };

  options.defaultOpts = {
    type = types.string;
    defaultFunc = { inputs, ... }: inputs.nixpkgs.lib.fileContents ./FZF_DEFAULT_OPTS;
  };

  options.ctrl-r = {
    type = types.struct "ctrl-r" {
      opts = types.string;
    };
    defaultFunc = { inputs, ... }: {
      opts = inputs.nixpkgs.lib.fileContents ./FZF_CTRL_R_OPTS;
    };
  };

  options.alt-c = {
    type = types.struct "alt-c" {
      opts = types.string;
      command = types.string;
    };
    defaultFunc = { inputs, ... }:
      let
        inherit (inputs.nixpkgs) lib;
      in {
        command = "${lib.getExe inputs.zoxide.drv} query --list --score";
        opts = lib.fileContents ./FZF_ALT_C_OPTS;
      };
  };

  # Injecting the options into the drv itself seemed to be very buggy - so I
  # just provide the options here, so they can be injected into the shell itself
  options.drv = {
    type = types.derivation;
    defaultFunc = { inputs, ... }: inputs.nixpkgs.pkgs.fzf;
  };
}
