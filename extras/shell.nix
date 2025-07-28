{ pkgs, inputs }:

let
  system = pkgs.system;
in pkgs.mkShellNoCC {
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

    nvim = inputs.meovim.packages.${system}.default;

    inherit (inputs.menu.legacyPackages.${system})
      rbld
      unify
      fuiska;

    inherit (inputs.gasp.legacyPackages.${system})
      ghp
      gfp
      gkp;
  };
}
