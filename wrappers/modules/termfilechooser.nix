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
      type = types.pathLike;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.xdg-desktop-portal-termfilechooser;
    };
  };

  impl =
    { options, inputs }:
    inputs.mkWrapper {
      inherit (options) package;
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
