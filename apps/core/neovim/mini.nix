{ pkgs, ... }:

{
  hm.programs.neovim.plugins =
  [
    {
      plugin = pkgs.vimPlugins.mini-trailspace;
      type = "lua";
      config =
      /* lua */
      ''
        require("mini.trailspace").setup({
          only_in_normal_buffers = false, -- Not sure if this is working
        })
        vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#e55c7a"} ) -- Git's "red reverse"
      '';
    }

    {
      plugin = pkgs.vimPlugins.mini-cursorword;
      type = "lua";
      config =
      /* lua */
      ''
        require("mini.cursorword").setup({
          delay = 10,
        })
      '';
    }

    {
      plugin = pkgs.vimPlugins.mini-move;
      type = "lua";
      config =
      /* lua */
      ''
        require("mini.move").setup()
      '';
    }
  ];
}
