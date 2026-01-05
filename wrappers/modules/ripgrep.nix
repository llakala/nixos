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
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.ripgrep;
    };
  };

  impl =
    { options, inputs }:
    inputs.mkWrapper {
      name = "rg";
      inherit (options) package flags;
    };
}
