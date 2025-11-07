{ adios }:
let
  inherit (adios) types;
in
{
  name = "starship";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.configPath = {
    type = types.path;
    default = ./starship.toml;
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
        name = "starship-wrapped";
        paths = [ pkgs.starship ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/starship \
            --set STARSHIP_CONFIG ${options.configPath}
        '';
        meta.mainProgram = "starship";
      };
  };
}
