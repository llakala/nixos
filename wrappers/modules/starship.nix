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
    configFile = {
      type = types.path;
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
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.starship;
      environment = {
        STARSHIP_CONFIG = options.configFile;
        XDG_CONFIG_HOME = inputs.git {}; # Makes starship follow /git/ignore for git status module
      };
    };
}
