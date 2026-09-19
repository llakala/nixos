local enter = vim.keycode("<CR>")

vim.keymap.set("n", "<C-l>", "<CR>", { buf = 0 })

vim.keymap.set("n", "<C-s>", function()
  local prev = vim.o.switchbuf
  vim.o.switchbuf = "useopen,vsplit"
  vim.api.nvim_feedkeys(enter, "nx", false)
  vim.o.switchbuf = prev
end, { buf = 0 })
