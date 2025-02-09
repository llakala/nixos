{ pkgs, lib, ... }:

{
  hm.programs.neovim.plugins = lib.singleton
  {
    plugin = pkgs.vimPlugins.nvim-autopairs;
    type = "lua";
    config =
    /* lua */
    ''
      require("nvim-autopairs").setup()
    '';
  };
}
