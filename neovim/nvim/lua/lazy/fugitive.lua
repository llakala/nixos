---@module "lz.n"
---@type lz.n.PluginSpec[]
return {
  {
    "vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Gedit",
      "Gsplit",
      "Gvsplit",
      "Gtabedit",
      "Gpedit",
      "Gdrop",
      "Gread",
      "Gwrite",
      "Gwq",
      "Gdiffsplit",
      "Gdiffsplit",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GUnlink",
      "GBrowse",
    },
    after = function()
      -- The whole point of lazy loading fugitive is so that this autocmd
      -- https://github.com/tpope/vim-rhubarb/blob/5496d7c94581c4c9ad7430357449bb57fc59f501/plugin/rhubarb.vim#L37
      -- doesn't run every single time we open a buffer. No, I'm sure this
      -- doesn't actually make a large difference, but I'm doing :verbose
      -- profiling, and having it gone makes me happy
      require("lz.n").trigger_load("vim-rhubarb")
      vim.g.fugitive_legacy_commands = false
    end,
  },
  {
    "vim-rhubarb",
    lazy = true,
  },
}
