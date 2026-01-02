{ adios }:
let
  inherit (adios) types;
in {
  name = "less";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    flags = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./LESS;
    };
    keybinds = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./lesskey;
    };
  };

  mutations = {
    "/git" = {
      iniConfig = { options, inputs }: import ./iniConfig.nix { inherit options inputs; };
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.less;
      environment = {
        LESS = options.flags;
        LESSKEY_CONTENT = options.keybinds;
      };
    };
}
