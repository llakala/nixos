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
    };
    configFile = {
      type = types.path;
    };
    package = {
      type = types.derivation;
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
