local max_lines = 2500
local bufnr = vim.api.nvim_get_current_buf()
if vim.api.nvim_buf_line_count(bufnr) > max_lines then
  vim.b.disable_treesitter = true
end
