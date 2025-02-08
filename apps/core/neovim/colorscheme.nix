{ inputs, lib, pkgs, ... }:

let
  plugins = inputs.neovimPlugins.packages.${pkgs.system};

in
{
  hm.programs.neovim =
  {
    plugins = lib.singleton plugins.onedarkpro-nvim;
    extraLuaConfig =
    /* lua */
    ''
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("onedark_vivid")
    '';
  };
}
