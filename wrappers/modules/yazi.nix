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
    settings = {
      type = types.attrs;
    };
    settingsFile = {
      type = types.pathLike;
    };

    keymap = {
      type = types.attrs;
    };
    keymapFile = {
      type = types.pathLike;
    };

    initLua = {
      type = types.string;
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
      inherit (inputs.nixpkgs) pkgs;
      inherit (builtins) listToAttrs attrValues mapAttrs;
      inherit (pkgs) writeText;
      generator = pkgs.formats.toml {};
    in
    assert !(options ? settings && options ? settingsFile);
    assert !(options ? keymap && options ? keymapFile);
    assert !(options ? initLua && options ? initLuaFile);
    inputs.mkWrapper {
      inherit (options) package;
      preWrap = ''
        mkdir -p $out/yazi/plugins
      '';
      symlinks = {
        "$out/yazi/yazi.toml" = options.settingsFile or (generator.generate "yazi.toml" options.settings);
        "$out/yazi/keymap.toml" = options.keymapFile or (generator.generate "keymap.toml" options.keymap);
        "$out/yazi/init.lua" = options.initLuaFile or (writeText "init.lua" options.initLua);
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
