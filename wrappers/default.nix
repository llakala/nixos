{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  lib = import "${sources.nixpkgs}/lib";
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  importModules = import "${sources.adios}/adios/lib/importModules.nix" {
    # Add my custom types
    adios = adios // rec {
      types = adios.types // {
        null = types.typedef "null" isNull;
        pathLike = types.union [
          types.path
          types.derivation
          types.string
        ];
      };
    };
  };

  # Take the actual modules providing APIs (soon to be upstreamed into their own
  # repo), and merge the attrsets deeply (think of it like a fancy version of
  # //). This allows my config to not just call impls, but add inputs, add
  # computed values, etc.
  root = {
    name = "root";
    modules = lib.recursiveUpdate (importModules ./modules) (importModules ./config);
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
  if wrapper.args.options ? __functor then
    (removeAttrs wrapper.args.options [ "__functor" ]) // { drv = wrapper {}; }
  else
    wrapper.args.options
) tree.root.modules
