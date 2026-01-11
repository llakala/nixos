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
      description = ''
        Settings injected into the wrapped package's configuration file.

        See the termfilechooser documentation for valid options:
        https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser#configuration
      '';
    };
    configFile = {
      type = types.pathLike;
      description = ''
        Configuration file to be injected into the wrapped package.

        See the termfilechooser documentation for valid options:
        https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser#configuration
      '';
    };
    package = {
      type = types.derivation;
      description = "The xdg-desktop-portal-termfilechooser package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.xdg-desktop-portal-termfilechooser;
    };
  };

  impl =
    { options, inputs }:
    let
      generator = inputs.nixpkgs.pkgs.formats.toml {};
    in
    assert !(options ? settings && options ? configFile);
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
