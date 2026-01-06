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
      type = types.pathLike;
    };
    keymapFile = {
      type = types.pathLike;
    };
    initLuaFile = {
      type = types.pathLike;
    };
    extraPackages = {
      type = types.listOf types.derivation;
    };
    plugins = {
      type = types.attrsOf types.pathLike;
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
