{ inputs, lib, pkgs, ... }:

let
  plugins = inputs.neovimPlugins.packages.${pkgs.system};
in
{
  hm.programs.neovim.plugins = lib.singleton
  {
    plugin = plugins.onedarkpro-nvim;
    type = "lua";
    config =
    /* lua */
    ''
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("onedark_vivid")
    '';
  };
}
