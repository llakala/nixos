{ types, promise, ... }:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
    zoxide.from = { parent }: parent.zoxide;
  };

  # Rather than injecting this into an actual wrapper, I recommend reading from
  # args.options of the fzf wrapper, and setting these in a nixpkgs context.
  # TODO: see if I can avoid this
  options = {
    defaultOpts = {
      type = types.string;
      default = promise ({ inputs }: inputs.nixpkgs.lib.fileContents ./FZF_OPTS);
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
        completion = types.struct "completion" {
          opts = types.string;
        };
      };
      default = promise (
        { inputs }:
        let
          inherit (inputs.nixpkgs) lib;
          zoxideWrapper = inputs.zoxide {};
        in
        {
          ctrl-r.opts = lib.fileContents ./CTRL_R_OPTS;
          alt-c = {
            command = "${lib.getExe zoxideWrapper} query --list --score";
            opts = lib.fileContents ./ALT_C_OPTS;
          };
          completion.opts = lib.fileContents ./COMPLETION_OPTS;
        }
      );
    };
    package = {
      type = types.derivation;
      default = promise ({ inputs }: inputs.nixpkgs.pkgs.fzf);
    };
  };

  mutations."/fish".interactiveShellInit = promise (
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) lib;
    in
    /* fish */ ''
      ${lib.getExe options.package} --fish | source
    ''
  );
}
