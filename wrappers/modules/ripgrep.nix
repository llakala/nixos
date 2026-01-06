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
    let
      inherit (builtins) filter attrNames;
      filterNullAttrs = set: removeAttrs set (filter (name: isNull set.${name}) (attrNames set));
    in
    assert !(options ? flags && options ? files);
    inputs.mkWrapper (filterNullAttrs {
      name = "rg";
      inherit (options) package;
      flags = options.flags or null;
      environment = {
        RIPGREP_CONFIG_PATH = options.configFile or null;
      };
    });
}
