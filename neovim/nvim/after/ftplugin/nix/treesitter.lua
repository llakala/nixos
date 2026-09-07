local max_lines = 2500
if vim.api.nvim_buf_line_count(0) > max_lines then
  vim.b.disable_treesitter = true
end
