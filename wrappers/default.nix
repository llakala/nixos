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
    name = "root";
    modules = {
      nixpkgs = import ./nixpkgs { inherit adios; };
      self = import ./self { inherit adios; };
      bat = import ./bat { inherit adios; };
      diff-so-fancy = import ./diff-so-fancy { inherit adios; };
      firefox = import ./firefox { inherit adios; };
      fzf = import ./fzf { inherit adios; };
      gh = import ./gh { inherit adios; };
      git = import ./git { inherit adios; };
      kittab = import ./kittab { inherit adios; };
      kitty = import ./kitty { inherit adios; };
      less = import ./less { inherit adios; };
      ripgrep = import ./ripgrep { inherit adios; };
      starship = import ./starship { inherit adios; };
      termfilechooser = import ./termfilechooser { inherit adios; };
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
