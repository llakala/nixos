{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  inherit (pkgs) lib;
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    name = "root";
    modules = adios.lib.importModules ./.;
  };

  eval = (adios root).eval {
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
  mapAttrs (_: wrapper: wrapper.args.options) eval.root.modules
