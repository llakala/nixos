{
  sources ? import ../other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ../other/myLib/default.nix { inherit pkgs; },
  packages ? import ../packages/default.nix { inherit sources pkgs myLib; },
}:

let
  inherit (builtins) mapAttrs;
  adios = import sources.adios;
  # adios = import ~/Documents/repos/adios;
  # adios-wrappers = import sources.adios-wrappers { inherit adios; };
  adios-wrappers = import ~/Documents/projects/adios-wrappers { inherit adios; };

  # See the adios docs on this:
  # https://github.com/llakala/lladios/blob/main/doc/src/lib/inject/index.md
  root = {
    modules = adios.lib.inject [
      adios-wrappers
      (adios.lib.importModules { directory = ./.; })
    ];
  };

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
      "/self" = {
        inherit myLib packages;
      };
    };
  };
in
# We have each wrapper `foo` point to all its options, so you can do
# `(import ./wrappers {}).foo.some-option`
mapAttrs (
  _: module:
  if module ? impl then
    (removeAttrs module.args.options [ "__functor" ])
    // {
      module = module;
      drv = module { };
    }
  else
    module.args.options
) tree.modules
