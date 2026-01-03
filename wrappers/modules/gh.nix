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
      type = types.path;
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
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.gh;
      environment = {
        GH_CONFIG_DIR = options.configDir;
      };
    };
}
