{ adios }:
{
  inputs = {
    zoxide.path = "/zoxide";
  };

  options = {
    defaultOpts.defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./FZF_OPTS;
    shellIntegration.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        zoxideWrapper = inputs.zoxide { };
      in {
        ctrl-r.opts = lib.fileContents ./CTRL_R_OPTS;
        alt-c = {
          command = "${lib.getExe zoxideWrapper} query --list --score";
          opts = lib.fileContents ./ALT_C_OPTS;
        };
      };
  };
}
