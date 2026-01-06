{ adios }:
let
  inherit (adios) types;
in {
  name = "gh";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    configDir = {
      type = types.pathLike;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.gh;
    };
  };

  mutations = {
    "/git".iniConfig =
      { inputs, options }:
      let
        inherit (inputs.nixpkgs) lib;
        finalWrapper = options {};
      in {
        credential."https://github.com".helper = "${lib.getExe finalWrapper} auth git-credential";
      };
  };

  impl =
    { options, inputs }:
    inputs.mkWrapper {
      inherit (options) package;
      environment = {
        GH_CONFIG_DIR = options.configDir;
      };
    };
}
