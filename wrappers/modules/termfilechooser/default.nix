{ adios }:
let
  inherit (adios) types;
in {
  name = "termfilechooser";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    configFile = {
      type = types.path;
      default = ./termfilechooser.toml;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.xdg-desktop-portal-termfilechooser;
      binaryPath = "$out/libexec/xdg-desktop-portal-termfilechooser";
      preWrap = ''
        mkdir -p $out/xdg-desktop-portal-termfilechooser
      '';
      symlinks = {
        "$out/xdg-desktop-portal-termfilechooser-config" = options.configFile;
      };
      environment = {
        XDG_CONFIG_HOME = "$out";
      };
    };
}
