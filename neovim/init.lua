-- Uncomment when you want to profile nvim startup. Be sure to have
-- the snacks.nvim repo cloned for this to work!
-- vim.opt.rtp:append("/home/emanresu/Documents/repos/snacks.nvim/")
-- require("snacks.profiler").startup({
--   presets = {
--     startup = { sort = true },
--   },
-- })

require("init")
require("lz.n").load("lazy")

-- Add to this whenever you add a new server to the `lsp` folder!
-- Ridiculous that nvim can't load them for you as far as I can tell
vim.lsp.enable({
  "fish_lsp",
  "gleam",
  "lua_ls",
  "nil_ls",
  "basedpyright",
  "ts_ls",
  "marksman",
  "tinymist",
  "clangd",
})
