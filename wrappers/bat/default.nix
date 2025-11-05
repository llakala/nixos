{ adios }:
let
  inherit (adios) types;
in
{
  name = "bat";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    less.path = "/less";
  };

  options.flags = {
    type = types.string;
    defaultFunc = { inputs, ... }: inputs.nixpkgs.lib.fileContents ./BAT_CONFIG;
 };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs lib;
        inherit (pkgs) symlinkJoin makeWrapper;
      in
      symlinkJoin {
        name = "bat-wrapped";
        paths = [ pkgs.bat ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/bat \
            --add-flags "${options.flags}" \
            --add-flags "--pager='${lib.getExe inputs.less.drv} -RFX'"
        '';
      };
  };
}
