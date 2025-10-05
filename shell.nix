{ sources ? import ./various/npins, pkgs ? import sources.nixpkgs {} }:
let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
  gasp = import "${sources.gasp}/packages/default.nix" { inherit pkgs; };
  meovim = import "${sources.meovim}/default.nix" { inherit pkgs; mnw = import sources.mnw; };
in
  pkgs.mkShellNoCC {
    packages = builtins.attrValues {
      inherit (pkgs)
        fish
        yazi
        git
        kitty
        gh
        erlang
        gleam
        rebar3
        elixir;

      nvim = meovim;

      inherit (menu)
        rbld
        unify
        fuiska;

      inherit (gasp)
        ghp
        gfp
        gkp;
    };
  }
