{ adios }:
let
  inherit (adios) types;
in {
  name = "starship";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    settings = {
      type = types.attrs;
    };
    configFile = {
      type = types.pathLike;
    };

    wrapperAttrs = {
      type = types.attrs;
      mutators = []; # Hack to make the mergeFunc be called with no mutators
      mutatorType = types.attrs;
      mergeFunc =
        { mutators, inputs, options }:
        let
          inherit (inputs.nixpkgs.lib) recursiveUpdate;
          inherit (adios.lib.mergeFuncs) mergeAttrsRecursively;
          generator = inputs.nixpkgs.pkgs.formats.toml {};
          default =
            assert !(options ? settings && options ? configFile);
            {
              inherit (options) package;
              environment = {
                STARSHIP_CONFIG = options.configFile or (generator.generate "starship.toml" options.settings);
              };
            };
        in
        # Allow mutators to change the default value, with the mutators taking
        # priority if the key is the same
        recursiveUpdate default (mergeAttrsRecursively { inherit mutators; });
    };

    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.starship;
    };
  };

  mutations."/fish".interactiveShellInit =
    { options, inputs }:
    let
      finalWrapper = options {};
      inherit (inputs.nixpkgs) lib;
    in
    # fish
    ''
      ${lib.getExe finalWrapper} init fish | source
    '';


  impl = { options, inputs }: inputs.mkWrapper options.wrapperAttrs;
}
