{ inputs, pkgs, lib, config, ... }:

let
  neovimPackage = inputs.meovim.packages.${pkgs.system}.default;
in
{
  environment.variables.EDITOR = "nvim";

  hm.programs.fish.shellAbbrs =

  # Error if we ever change shell
  assert config.features.abbreviations == "fish";
  {
    n = "nvim";
  };

  # If we ever stop using Neovim, change this
  features.editor = "neovim";

  environment.systemPackages = lib.singleton neovimPackage;
}
