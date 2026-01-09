{ adios }:
let
  inherit (adios) types;
in {
  name = "ripgrep";

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
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.ripgrep;
    };
  };

  impl =
    { options, inputs }:
    assert !(options ? flags && options ? configFile);
    if options ? flags then
      inputs.mkWrapper {
        name = "rg";
        inherit (options) package;
        flags = options.flags;
      }
    else
      inputs.mkWrapper {
        name = "rg";
        environment = {
          RIPGREP_CONFIG_PATH = options.configFile;
        };
      };
}
