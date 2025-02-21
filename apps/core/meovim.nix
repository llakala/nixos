{ inputs, pkgs, lib, config, ... }:

let
  neovimPackage = inputs.meovim.packages.${pkgs.system}.default;
in
{
  environment.variables.EDITOR = "nvim";

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    n = "nvim";
  };

  features.editor = "neovim"; # If we ever stop using Neovim, change this

  environment.systemPackages = lib.singleton neovimPackage;
}
