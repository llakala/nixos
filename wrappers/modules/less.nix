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
    };
    keybinds = {
      type = types.string;
    };
    keybindsFile = {
      type = types.path;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.less;
    };
  };

  impl =
    { options, inputs }:
    assert !(options ? keybinds && options ? keybindsFile);
    inputs.mkWrapper {
      inherit (options) package;
      environment = {
        LESS = options.flags;
        LESSKEY_CONTENT = options.keybinds or null;
        LESSKEYIN = options.keybindsFile or null;
      };
    };
}
