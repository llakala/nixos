{ adios }:
let
  inherit (adios) types;
in {
  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    settingsFile = {
      type = types.path;
      default = ./yazi.toml;
    };
    keymapFile = {
      type = types.path;
      default = ./keymap.toml;
    };
    initLua = {
      type = types.path;
      default = ./init.lua;
    };

    extraPackages = {
      type = types.listOf types.derivation;
      defaultFunc = { inputs }: import ./extraPackages.nix { inherit inputs; };
    };
    plugins = {
      type = types.attrsOf (types.union [ types.path types.derivation ]);
      defaultFunc = { inputs }: import ./plugins.nix { inherit inputs; };
    };

    configDir = {
      type = types.derivation;
      defaultFunc =
        { inputs, options }:
        let
          inherit (inputs.nixpkgs) pkgs lib;
          inherit (lib) mapAttrsToList;
          inherit (pkgs) linkFarm;
        in
        linkFarm "yazi-config" ([
          { name = "yazi/yazi.toml"; path = options.settingsFile; }
          { name = "yazi/keymap.toml"; path = options.keymapFile; }
          { name = "yazi/init.lua"; path = options.initLua; }
        ]
        ++ mapAttrsToList (name: path: {
          name = "yazi/plugins/${name}";
          inherit path;
        }) options.plugins);
    };
  };

  impl =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) pkgs lib;
      inherit (lib) makeBinPath;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "yazi-wrapped";
      paths = [ pkgs.yazi-unwrapped options.configDir ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        wrapProgram $out/bin/yazi \
          --prefix PATH : ${makeBinPath options.extraPackages} \
          --set YAZI_CONFIG_HOME $out/yazi
      '';
      meta.mainProgram = "yazi";
    };
}
