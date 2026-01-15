{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  lib = import "${sources.nixpkgs}/lib";
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";
  adios-wrappers = import sources.adios-wrappers { adios = sources.adios; };
  # adios-wrappers = import ~/Documents/projects/adios-wrappers { adios = sources.adios; };

  # Take the actual modules providing APIs (soon to be upstreamed into their own
  # repo), and merge the attrsets deeply (think of it like a fancy version of
  # //). This allows my config to not just call impls, but add inputs, add
  # computed values, etc.
  root = {
    name = "root";
    modules = myLib.recursiveUpdate adios-wrappers (adios.lib.importModules ./.);
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
