{ types, ... }:
{
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
  };

  mutations."/fish".interactiveShellInit =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) lib;
      finalWrapper = options {};
    in
    /* fish */ ''
      ${lib.getExe finalWrapper} --fish | source
    '';

  impl =
    { inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) fzf fetchFromGitHub;
    in
    # Waiting on https://github.com/NixOS/nixpkgs/pull/495823
    fzf.overrideAttrs {
      version = "0.70.0";
      src = fetchFromGitHub {
        owner = "junegunn";
        repo = "fzf";
        rev = "eacef5ea6e39c6be3fff4e231fc6d10ba2ff9491";
        hash = "sha256-axp2w4gzf6c+W0bUCR2Kjms1eaWQR1Ii0Axdaquy8XE=";
      };
    };
}
