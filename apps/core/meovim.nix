{ inputs, pkgs, lib, ... }:

let
  neovimPackage = inputs.meovim.packages.${pkgs.system}.default;
in
{
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = lib.singleton neovimPackage;
}
