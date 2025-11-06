{ adios }:
let
  inherit (adios) types;
in
{
  name = "gh";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.path = {
    type = types.path;
    default = ./gh;
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) symlinkJoin makeWrapper;
      in
      symlinkJoin {
        name = "gh-wrapped";
        paths = [ pkgs.gh ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/gh \
            --set GH_CONFIG_DIR "${options.path}" \
        '';
        meta.mainProgram = "gh";
      };
  };
}
