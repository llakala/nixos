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
    settings = {
      type = types.attrs;
    };
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
    let
      generator = inputs.nixpkgs.pkgs.formats.toml {};
    in
    assert !(options ? configFile && options ? settings);
    inputs.mkWrapper {
      inherit (options) package;
      binaryPath = "$out/libexec/xdg-desktop-portal-termfilechooser";
      preWrap = ''
        mkdir -p $out/xdg-desktop-portal-termfilechooser
      '';
      symlinks = {
        "$out/xdg-desktop-portal-termfilechooser/config" = options.configFile or (generator.generate "config" options.settings);
      };
      environment = {
        XDG_CONFIG_HOME = "$out";
      };
    };
}
