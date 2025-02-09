{ inputs, pkgs, lib, ... }:

let
  neovimPackage = inputs.meovim.packages.${pkgs.system}.default;
in
{
  environment.variables.EDITOR = "nvim";
  features.editor = "neovim"; # If we ever stop using Neovim, change this

  environment.systemPackages = lib.singleton neovimPackage;
}
