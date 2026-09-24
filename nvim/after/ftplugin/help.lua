-- Follow and return from tag link
vim.keymap.set("n", "<CR>", "<C-]>", { buf = 0 })
vim.keymap.set("n", "<BS>", "<C-T>", { buf = 0 })

-- Color tag links blue to be more visually distinct from mini.cursorword
vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { fg = colors.blue })

vim.wo.wrap = false
vim.b.miniindentscope_disable = true

-- upon opening the loclist, jump to the closest heading to the cursor
local custom_qf = require("custom.quickfix")
local ts_headings = require("vim.treesitter._headings")
vim.keymap.set("n", "gO", function()
  custom_qf.jump_to_nearest_entry()
  ts_headings.show_toc()
end, { buf = 0 })
