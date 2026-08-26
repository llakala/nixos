require("luasnip").setup({
  enable_autosnippets = true,
  snip_env = {
    in_ts_group = Custom.in_ts_group,
  },
})

require("luasnip.loaders.from_lua").lazy_load({
  lazy_paths = { "/home/emanresu/Documents/projects/nixos/neovim/nvim/snippets/" },
})
