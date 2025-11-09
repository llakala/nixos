{ adios }:
let
  inherit (adios) types;
in
{
  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.settingsFile = {
    type = types.path;
    default = ./yazi.toml;
  };
  options.keymapFile = {
    type = types.path;
    default = ./keymap.toml;
  };
  options.initLua = {
    type = types.path;
    default = ./init.lua;
  };

  options.extraPackages = {
    type = types.listOf types.derivation;
    defaultFunc = { inputs }: import ./extraPackages.nix { inherit inputs; };
  };
  options.plugins = {
    type = types.attrsOf (
      types.union [
        types.path
        types.derivation
      ]
    );
    defaultFunc = { inputs }: import ./plugins.nix { inherit inputs; };
  };

  options.configDir = {
    type = types.derivation;
    defaultFunc =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) pkgs lib;
      inherit (lib) mapAttrsToList;
      inherit (pkgs) linkFarm;
    in
    linkFarm "yazi-config" ([
      { name = "yazi.toml"; path = options.settingsFile; }
      { name = "keymap.toml"; path = options.keymapFile; }
      { name = "init.lua"; path = options.initLua; }
    ]
    ++ mapAttrsToList (name: path: {
      name = "plugins/${name}";
      inherit path;
    }) options.plugins);
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { inputs, options }:
      let
        inherit (inputs.nixpkgs) pkgs lib;
        inherit (lib) makeBinPath;
        inherit (pkgs) symlinkJoin makeWrapper;
      in
      symlinkJoin {
        name = "yazi-wrapped";
        paths = [ pkgs.yazi-unwrapped ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/yazi \
            --prefix PATH : ${makeBinPath options.extraPackages} \
            --set YAZI_CONFIG_HOME ${options.configDir}
        '';
        meta.mainProgram = "yazi";
      };
  };
}
