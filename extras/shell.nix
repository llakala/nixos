{ pkgs, inputs }:

let
  nixpkgsPackages = with pkgs; [
    fish
    yazi
    git
    kitty
    gh

    erlang
    gleam
    rebar3
    elixir
  ];

  system = pkgs.system;

  otherPackages = [
    inputs.meovim.packages.${system}.default

    inputs.menu.legacyPackages.${system}.fuiska
    inputs.menu.legacyPackages.${system}.rbld
    inputs.menu.legacyPackages.${system}.unify

    inputs.gasp.legacyPackages.${system}.ghp
    inputs.gasp.legacyPackages.${system}.gfp
    inputs.gasp.legacyPackages.${system}.gkp
  ];

in pkgs.mkShellNoCC {
  packages = nixpkgsPackages ++ otherPackages;
}
