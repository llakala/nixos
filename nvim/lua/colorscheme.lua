-- Global variable for access elsewhere
-- Check the value with:
-- :tabnew Colors|pu=execute(':=colors')
-- Putting it in a buffer lets it be colorized with our hexcode previewer
-- TODO: add an alias to do this easily
colors = require("tokyonight.colors").setup()

require("tokyonight").setup({
  style = "night",

  on_highlights = function(hl, colors)
    hl["@variable"] = { fg = colors.red }
    hl.ColorColumn = { bg = colors.bg_highlight }
    hl.WinSeparator = { fg = "#868eb6" }
    hl.Search = { bg = colors.fg_gutter }
  end,
})

vim.cmd([[colorscheme tokyonight]])

vim.g.colorizer_auto_filetype = "*"
