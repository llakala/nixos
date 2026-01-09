{ adios }:
let
  inherit (adios) types;
in {
  name = "gh";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    settings = {
      type = types.attrs;
    };
    configDir = {
      type = types.pathLike;
    };
    hosts = {
      type = types.attrs;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.gh;
    };
  };

  mutations = {
    "/git".settings =
      { inputs, options }:
      let
        inherit (inputs.nixpkgs) lib;
        finalWrapper = options {};
      in {
        credential."https://github.com".helper = "${lib.getExe finalWrapper} auth git-credential";
      };
  };

  impl =
    { options, inputs }:
    let
      inherit (builtins) mapAttrs;
      generator = inputs.nixpkgs.pkgs.formats.yaml { };
      mapBools = mapAttrs (
        _: value:
        if value == true then "enabled"
        else if value == false then "disabled"
        else value
      );
    in
    assert !(options ? configDir && (options ? settings || options ? hosts));
    if options ? configDir then
      inputs.mkWrapper {
        inherit (options) package;
        environment = {
          GH_CONFIG_DIR = options.configDir;
        };
      }
    else
      inputs.mkWrapper {
        inherit (options) package;
        preWrap = ''
          mkdir -p $out/gh
        '';
        symlinks = {
          "$out/gh/config.yml" =
            if options ? settings then generator.generate "config" (mapBools options.settings) else null;
          "$out/gh/hosts.yml" =
            if options ? hosts then generator.generate "hosts" (mapBools options.hosts) else null;
        };
        environment = {
          GH_CONFIG_DIR = "$out/gh";
        };
      };
}
