{
  sources ? import ../various/npins,
  pkgs ? import sources.nixpkgs { },
  myLib ? import ../various/myLib/default.nix { inherit pkgs; }
}:

let
  inherit (pkgs) lib;
  inherit (builtins) mapAttrs;
  adios = import "${sources.adios}/adios";

  root = {
    modules = {
      bat = import ./bat { inherit adios; };
      fzf = import ./fzf { inherit adios; };
      gh = import ./gh { inherit adios; };
      kittab = import ./kittab { inherit adios; };
      kitty = import ./kitty { inherit adios; };
      less = import ./less { inherit adios; };
      ripgrep = import ./ripgrep { inherit adios; };
      self = import ./self { inherit adios; };
      nixpkgs = import ./nixpkgs { inherit adios; };
      zoxide = import ./zoxide { inherit adios; };
    };
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
  mapAttrs (_: wrapper: wrapper.args.options) eval.tree.modules
