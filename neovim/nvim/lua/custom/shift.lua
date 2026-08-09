--- Custom version of > and < that keeps the cursor on the same line before/after
--- shifting. Works with dot repeat by reimplementing the operators in lua
local M = {}
M.cache = {}

-- This function only triggers if we're not dot repeating. If we are, the cached
-- op is reused, and the cached pos should be set again in a remap
M.operator = function(op)
  M.cache = { op = op, pos = vim.api.nvim_win_get_cursor(0) }
  vim.go.operatorfunc = "v:lua.require'custom.shift'.operator_callback"
  return "g@"
end

M.operator_callback = function()
  -- why is vim.bo.shiftwidth typed with string | integer | true, while
  -- vim.o.shiftwidth is just an integer?
  local shiftwidth = vim.bo.shiftwidth > 0 and vim.bo.shiftwidth or vim.bo.tabstop
  local sign = M.cache.op == ">" and 1 or -1

  local first_lnum = vim.api.nvim_buf_get_mark(0, "[")[1] - 1
  local last_lnum = vim.api.nvim_buf_get_mark(0, "]")[1]
  local lines = vim.api.nvim_buf_get_lines(0, first_lnum, last_lnum, true)

  -- reimplementation of the shift operator, so we don't have to call it and set
  -- the dot repeat operator
  local end_col, current_indent, lnum
  for i, line in ipairs(lines) do
    -- get the first n characters of the line
    end_col = math.min(string.len(line), shiftwidth)
    line = string.sub(line, 0, end_col)

    -- reindent the line by n spaces
    _, current_indent = vim.text.indent(0, line)
    line = vim.text.indent(current_indent + shiftwidth * sign, line, { expandtab = 1 })

    -- put the new text back in the original charwise range
    lnum = first_lnum + i - 1
    vim.api.nvim_buf_set_text(0, lnum, 0, lnum, end_col, { line })
  end

  -- move the column if moving to the right, or current line can actually be
  -- indented
  local _, cursor_indent = vim.text.indent(0, vim.fn.getline(M.cache.pos[1]))
  if sign == 1 or cursor_indent >= 0 then
    M.cache.pos[2] = math.max(0, M.cache.pos[2] + shiftwidth * sign)
  end

  vim.api.nvim_win_set_cursor(0, M.cache.pos)
end

return M
