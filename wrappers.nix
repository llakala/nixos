{
  sources ? import ./other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ./other/myLib/default.nix { inherit pkgs; }
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
      (adios.lib.importModules { directory = ./wrappers; })
    ];
  };

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
      "/self" = {
        inherit myLib;
      };
    };
  };
in
# We have each wrapper `foo` point to all its options, so you can do
# `(import ./wrappers.nix {}).foo.some-option`
mapAttrs (
  _: wrapper:
  if wrapper ? impl then
    (removeAttrs wrapper.args.options [ "__functor" ]) // { drv = wrapper {}; }
  else
    wrapper.args.options
) tree.modules
