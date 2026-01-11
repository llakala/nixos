{ adios }:
let
  inherit (adios) types;
in {
  name = "bat";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    flags = {
      type = types.listOf types.string;
      description = ''
        Flags to be appended by default when running bat.

        Disjoint with the `configFile` option.
      '';
    };
    configFile = {
      type = types.pathLike;
      description = ''
        File containing the flags to be appended by default when running bat.

        Disjoint with the `flags` option.
      '';
    };
    package = {
      type = types.derivation;
      description = "The bat package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.bat;
    };
  };

  impl =
    { options, inputs }:
    assert !(options ? flags && options ? configFile);
    if options ? flags then
      inputs.mkWrapper {
        inherit (options) package flags;
      }
    else
      inputs.mkWrapper {
        inherit (options) package;
        environment = {
          BAT_CONFIG_PATH = options.configFile;
        };
      };
}
