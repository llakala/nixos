{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  lib = import "${sources.nixpkgs}/lib";
  inherit (builtins) mapAttrs;
  inherit (lib) foldlAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    name = "root";
    modules = adios.lib.importModules ./.;
  };

  tree = (adios root).eval {
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
  foldlAttrs (
    acc: arg: value:
    # Remove the functor from the args if it exists, instead preferring to access
    # the final result through `.drv`
    if arg == "__functor" then
      acc // { drv = wrapper {}; }
    else
      acc // { ${arg} = value; }
  ) {} wrapper.args.options
) tree.root.modules
