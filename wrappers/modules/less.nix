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
      description = ''
        Flags to be automatically appended when running less.

        See the documentation for valid options:
        https://man7.org/linux/man-pages/man1/less.1.html#:~:text=OPTIONS,-top

        Disjoint with the `configFile` option.
      '';
    };
    configFile = {
      type = types.pathLike;
      description = ''
        File containing flags to be automatically appended when running less.

        See the documentation for valid options:
        https://man7.org/linux/man-pages/man1/less.1.html#:~:text=OPTIONS,-top

        Disjoint with the `settings` option.
      '';
    };

    # TODO: change this to configFile, and add individual RFC42 options that
    # modify each of the sections.
    keybindsFile = {
      type = types.pathLike;
    };

    package = {
      type = types.derivation;
      description = "The less package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.less;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (builtins) concatStringsSep;
    in
    assert !(options ? flags && options ? configFile);
    assert !(options ? keybinds && options ? keybindsFile);
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
