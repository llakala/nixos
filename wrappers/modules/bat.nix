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
      type = types.string;
    };
    configFile = {
      type = types.path;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    assert !(options ? flags && options ? configFile);
    if options ? flags then
      inputs.mkWrapper {
        package = pkgs.bat;
        wrapperArgs = ''
          --add-flags "${options.flags}"
        '';
      }
    else
      inputs.mkWrapper {
        package = pkgs.bat;
        environment = {
          BAT_CONFIG_PATH = options.configFile;
        };
      };
}
