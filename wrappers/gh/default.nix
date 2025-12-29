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
      default = ./gh;
    };
  };

  mutations = {
    "/git".iniConfig = { options, inputs }: import ./iniConfig.nix { inherit options inputs; };
    "/fish".abbreviations = _: import ./abbreviations.nix;
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.gh;
      symlinks = {
        "$out/gh" = options.configDir;
      };
      environment = {
        GH_CONFIG_DIR = "$out/gh";
      };
    };
}
