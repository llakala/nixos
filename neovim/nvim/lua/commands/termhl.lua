-- Highlight current buffer's ansi escape codes
vim.api.nvim_create_user_command("TermHl", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local b = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_set_option_value("buftype", "nofile", { buf = b })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = b })
  vim.api.nvim_set_option_value("swapfile", false, { buf = b })

  local chan = vim.api.nvim_open_term(b, {})
  vim.api.nvim_chan_send(chan, table.concat(lines, "\n"))
  vim.api.nvim_win_set_buf(0, b)
end, { desc = "Highlights ANSI termcodes in curbuf" })
