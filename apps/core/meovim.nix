{ inputs, pkgs, lib, config, ... }:

let
  neovimPackage = inputs.meovim.packages.${pkgs.system}.default;
in
{
  environment.variables.EDITOR = "nvim";

  # For when you want nvim as your manpager! I use bat by default for better
  # syntax highlighting, but I can use this when I want to follow local links
  # better.
  environment.shellAliases.vman = "MANPAGER='nvim +Man!' man";

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    v = "nvim";
  };

  features.editor = "neovim"; # If we ever stop using Neovim, change this

  environment.systemPackages = lib.singleton neovimPackage;
}
