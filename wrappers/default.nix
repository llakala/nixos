{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  lib = import "${sources.nixpkgs}/lib";
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    name = "root";
    modules = adios.lib.importModules ./modules;
  };

  overrides = {
    name = "overridden-root";
    modules = adios.lib.importModules ./config;
  };

  tree = (adios (lib.recursiveUpdate root overrides)).eval {
    options = {
      "/nixpkgs" = {
        inherit pkgs lib;
      };
      "/self" = {
        inherit myLib;
      };
    };
  };
in
# We have each wrapper `foo` point to all its options, so you can do
# `(import ./wrappers {}).foo.some-option`
mapAttrs (
  _: wrapper:
  if wrapper.args.options ? __functor then
    (removeAttrs wrapper.args.options [ "__functor" ]) // { drv = wrapper {}; }
  else
    wrapper.args.options
) tree.root.modules
