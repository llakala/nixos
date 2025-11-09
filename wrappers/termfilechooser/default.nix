{ adios }:
let
  inherit (adios) types;
in
{
  name = "termfilechooser";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.configFile = {
    type = types.path;
    default = ./termfilechooser.toml;
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
        name = "termfilechooser-wrapped";
        paths = [ pkgs.xdg-desktop-portal-termfilechooser ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          mkdir -p $out/xdg-desktop-portal-termfilechooser
          ln -s ${options.configFile} $out/xdg-desktop-portal-termfilechooser/config
          wrapProgram $out/libexec/xdg-desktop-portal-termfilechooser \
            --set XDG_CONFIG_HOME $out
        '';
      };
  };
}
