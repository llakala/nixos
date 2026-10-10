-- Highlight current buffer's ansi escape codes
vim.api.nvim_create_user_command("AnsiHL", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local b = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, b)

  local chan = vim.api.nvim_open_term(b, {})
  vim.api.nvim_chan_send(chan, table.concat(lines, "\n"))
end)
