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
      description = ''
        Settings to be injected into the wrapped package's `config.yml`.

        See the documentation:
        https://cli.github.com/manual/gh_config

        Disjoint with the `configDir` option.
      '';
    };
    hosts = {
      type = types.attrs;
      description = ''
        Host information to be injected into the wrapped package's `hosts.yml`.

        Disjoint with the `configDir` option.
      '';
    };
    configDir = {
      type = types.pathLike;
      description = ''
        Folder containing gh configuration files to be injected into the wrapped package.

        This folder should contain a `config.yml` and/or a `hosts.yml`.

        Disjoint with the `settings` and `hosts` options.
      '';
    };
    package = {
      type = types.derivation;
      description = "The gh package to be wrapped.";
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
      generator = inputs.nixpkgs.pkgs.formats.yaml {};
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
