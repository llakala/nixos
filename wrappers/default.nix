{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs { },
  myLib ? import ../various/myLib/default.nix { inherit pkgs; },
}:

let
  lib = import "${sources.nixpkgs}/lib";
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    name = "root";
    modules = adios.lib.importModules ./modules;
  };

  tree = (adios root.eval {
    options = {
      "/nixpkgs" = {
        inherit pkgs lib;
      };
    };
  });

  wrapperModules = mapAttrs (name: module: module.args.options) tree.root.modules;
  wrappers = myLib.callNixFiles ./config (pkgs // {
    inherit wrappers wrapperModules;
  });
in
  wrappers
