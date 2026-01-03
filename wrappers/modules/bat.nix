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
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.bat;
      wrapperArgs = ''
        --add-flags "${options.flags}"
      '';
    };
}
