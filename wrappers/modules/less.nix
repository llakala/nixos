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
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    assert !(options ? keybinds && options ? keybindsFile);
    inputs.mkWrapper {
      package = pkgs.less;
      environment = {
        LESS = options.flags;
        LESSKEY_CONTENT = options.keybinds or null;
        LESSKEYIN = options.keybindsFile or null;
      };
    };
}
