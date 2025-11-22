{ adios }:
let
  inherit (adios) types;
in {
  name = "self";

  options.myLib = {
    type = types.attrs;
  };
}
