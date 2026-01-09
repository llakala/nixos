{ adios }:
let
  inherit (adios) types;
in {
  name = "starship";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
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
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.starship;
    };
  };

  mutations."/fish".interactiveShellInit =
    { options, inputs }:
    let
      finalWrapper = options {};
      inherit (inputs.nixpkgs) lib;
    in
    # fish
    ''
      ${lib.getExe finalWrapper} init fish | source
    '';

  impl =
    { options, inputs }:
    let
      generator = inputs.nixpkgs.pkgs.formats.toml {};
    in
    assert !(options ? settings && options ? configFile);
    inputs.mkWrapper {
      inherit (options) package;
      environment = {
        STARSHIP_CONFIG = options.configFile or (generator.generate "starship.toml" options.settings);
        XDG_CONFIG_HOME = inputs.git {}; # TODO: make this optional
      };
    };
}
