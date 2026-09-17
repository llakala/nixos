-- No, that's not a typo, the string has setup in it
require("rainbow-delimiters.setup").setup({
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterViolet",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
  },
})

require("custom/dynamic_indent").setup({ pattern = "*.md" })

-- Enable synchronous treesitter parsing to prevent flashing
vim.g._ts_force_sync_parsing = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.treesitter.language._complete(),
  group = vim.api.nvim_create_augroup("LoadTreesitter", {}),
  callback = function()
    if not vim.b.disable_treesitter then
      vim.treesitter.start()
    end
  end,
})

require("fundo").setup()
