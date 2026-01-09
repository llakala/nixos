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
      type = types.listOf types.string;
    };
    configFile = {
      type = types.pathLike;
    };
    keybinds = {
      type = types.string;
    };
    keybindsFile = {
      type = types.pathLike;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.less;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (builtins) concatStringsSep;
    in
    assert !(options ? keybinds && options ? keybindsFile);
    assert !(options ? flags && options ? configFile);
    inputs.mkWrapper {
      inherit (options) package;
      environment = {
        LESS =
          if options ? flags then
            concatStringsSep " " options.flags
          else if options ? configFile then {
            readFromFile = true;
            value = options.configFile;
          }
          else null;
        LESSKEY_CONTENT = options.keybinds or null;
        LESSKEYIN = options.keybindsFile or null;
      };
    };
}
