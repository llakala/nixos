{ lib, pkgs, ... }:
{

  environment.variables.EDITOR = "nvim";
  hm.programs.neovim =
  {
    enable = true;
    extraLuaConfig = lib.fileContents ./init.lua;
  };
}
