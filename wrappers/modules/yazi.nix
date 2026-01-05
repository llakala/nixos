{ adios }:
let
  inherit (adios) types;
in {
  name = "yazi";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    settingsFile = {
      type = types.path;
    };
    keymapFile = {
      type = types.path;
    };
    initLuaFile = {
      type = types.path;
    };
    extraPackages = {
      type = types.listOf types.derivation;
    };
    plugins = {
      type = types.attrsOf (types.union [ types.path types.derivation ]);
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.yazi-unwrapped;
    };
  };

  impl =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs.lib) makeBinPath;
      inherit (builtins) listToAttrs attrValues mapAttrs;
    in
    inputs.mkWrapper {
      inherit (options) package;
      preWrap = ''
        mkdir -p $out/yazi/plugins
      '';
      symlinks = {
        "$out/yazi/yazi.toml" = options.settingsFile;
        "$out/yazi/keymap.toml" = options.keymapFile;
        "$out/yazi/init.lua" = options.initLuaFile;
      } // listToAttrs (
        attrValues (
          mapAttrs (name: value: {
            name = "$out/yazi/plugins/${name}";
            inherit value;
          }) options.plugins
        )
      );
      wrapperArgs = ''
        --prefix PATH : ${makeBinPath options.extraPackages}
      '';
      environment = {
        YAZI_CONFIG_HOME = "$out/yazi";
      };
    };
}
