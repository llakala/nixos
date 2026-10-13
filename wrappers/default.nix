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
  adios-wrappers = import sources.adios-wrappers { inherit adios; };
  # adios-wrappers = import ~/Documents/projects/adios-wrappers { inherit adios; };

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
mapAttrs (
  _: module:
  if module ? __functor then
    module.args
    // {
      call = { inherit (module) __functor; };
    }
  else
    module.args
) tree.modules
