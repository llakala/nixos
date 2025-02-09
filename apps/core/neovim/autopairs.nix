{ pkgs, lib, ... }:

{
  hm.programs.neovim.plugins = lib.singleton pkgs.vimPlugins.nvim-autopairs;

  hm.programs.neovim.extraLuaConfig =
  /* lua */
  ''
    require("nvim-autopairs").setup()
  '';
}
