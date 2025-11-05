{ sources ? import ../various/npins, pkgs ? import sources.nixpkgs {} }:

let
  inherit (pkgs) lib;
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    modules = {
      less = import ./less { inherit adios; };
      nixpkgs = import ./nixpkgs { inherit adios; };
    };
  };

  eval = (adios root).eval {
    options."/nixpkgs" = {
      inherit pkgs lib;
    };
  };
in
  # We have each wrapper `foo` point to all its options, so you can do
  # `(import ./wrappers {}).foo.some-option`
  mapAttrs (_: wrapper: wrapper.args.options) eval.tree.modules
