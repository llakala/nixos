vim.keymap.set({ "n", "x" }, "y", function()
  vim.b.cursor_pre_yank = vim.api.nvim_win_get_cursor(0)
  return "y"
end, { expr = true })

-- Yank into selection clipboard (the one used for middle click paste)
vim.keymap.set("n", "gy", function()
  vim.b.cursor_pre_yank = vim.api.nvim_win_get_cursor(0)
  return '"*y'
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking, and keep cursor in the same place",
  group = vim.api.nvim_create_augroup("YankLogic", {}),
  callback = function()
    vim.hl.on_yank()
    if vim.v.event.operator == "y" and vim.b.cursor_pre_yank ~= nil then
      vim.api.nvim_win_set_cursor(0, vim.b.cursor_pre_yank)
      vim.b.cursor_pre_yank = nil
    end
  end,
})
