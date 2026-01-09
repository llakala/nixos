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
    assert !(options ? configFile && options ? settings);
    if options ? configFile then
      inputs.mkWrapper {
        inherit (options) package;
        environment = {
          STARSHIP_CONFIG = options.configFile;
          XDG_CONFIG_HOME = inputs.git {}; # Makes starship follow /git/ignore for git status module
        };
      }
    else
      inputs.mkWrapper {
        inherit (options) package;
        environment = {
          STARSHIP_CONFIG = generator.generate "starship.toml" options.settings;
          XDG_CONFIG_HOME = inputs.git {};
        };
      };
}
