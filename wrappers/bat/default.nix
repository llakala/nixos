{ adios }:
let
  inherit (adios) types;
in {
  name = "bat";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
    less.path = "/less";
  };

  options = {
    flags = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./BAT_CONFIG;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs lib;
      lessWrapper = inputs.less {};
    in
    inputs.mkWrapper {
      package = pkgs.bat;
      wrapperArgs = ''
        --add-flags "${options.flags}" \
        --add-flags "--pager='${lib.getExe lessWrapper} -RFX'"
      '';
    };
}
