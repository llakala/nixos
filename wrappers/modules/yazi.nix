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
      description = ''
        Settings injected into the wrapped package's `yazi.toml`.

        See the documentation for valid options:
        https://yazi-rs.github.io/docs/configuration/yazi

        Disjoint with the `settingsFile` option.
      '';
    };
    settingsFile = {
      type = types.pathLike;
      description = ''
        `yazi.toml` file to be injected into the wrapped package.

        See the documentation for valid options:
        https://yazi-rs.github.io/docs/configuration/yazi

        Disjoint with the `settings` option.
      '';
    };

    keymap = {
      type = types.attrs;
      description = ''
        Keybinds injected into the wrapped package's `keymap.toml`.

        See the documentation for valid options:
        https://yazi-rs.github.io/docs/configuration/keymap

        Disjoint with the `keymapFile` option.
      '';
    };
    keymapFile = {
      type = types.pathLike;
      description = ''
        `keymap.toml` file to be injected into the wrapped package.

        See the documentation for valid options:
        https://yazi-rs.github.io/docs/configuration/keymap

        Disjoint with the `keymap` option.
      '';
    };

    initLua = {
      type = types.string;
      description = ''
        Lua script to be injected into the wrapped package's `init.lua`.

        See the documentation on how to use the Yazi API:
        https://yazi-rs.github.io/docs/plugins/overview

        Disjoint with the `initLuaFile` option.
      '';
    };
    initLuaFile = {
      type = types.pathLike;
      description = ''
        `init.lua` file to be injected into the wrapped package.

        See the documentation on how to use the Yazi API:
        https://yazi-rs.github.io/docs/plugins/overview

        Disjoint with the `initLua` option.
      '';
    };

    extraPackages = {
      type = types.listOf types.derivation;
      description = ''
        Packages to be automatically added as Yazi dependencies.

        This defaults to the optionalDeps of the Yazi package in nixpkgs, set here:
        https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ya/yazi/package.nix#L8
      '';
      defaultFunc =
        { inputs }:
        with inputs.nixpkgs.pkgs; [
          jq
          poppler-utils
          _7zz
          ffmpeg
          fd
          ripgrep
          fzf
          zoxide
          imagemagick
          chafa
          resvg
        ];
    };
    plugins = {
      type = types.attrsOf types.pathLike;
      description = ''
        Attribute set of plugins to be injected into the wrapped package.

        Each attribute should map the name of a plugin (suffixed with `.yazi`) to the path or derivation containing the plugin's contents.
      '';
    };
    package = {
      type = types.derivation;
      description = ''
        The yazi package to be wrapped.
        Note that this should use a `-unwrapped` variant.
      '';
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
