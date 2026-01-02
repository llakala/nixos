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
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./ripgreprc;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      name = "rg";
      package = pkgs.ripgrep;
      wrapperArgs = ''
        --add-flags '${options.flags}'
      '';
    };
}
