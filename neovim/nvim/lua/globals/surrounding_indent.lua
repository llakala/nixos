local MiniIndentscope = require("mini.indentscope")
local ns = vim.api.nvim_create_namespace("scope_border")

Custom.operate_on_surrounding_indent = function()
  local win = vim.api.nvim_get_current_win()
  local buf = 0

  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  local operator, count1 = vim.v.operator, vim.v.count1

  if not vim.tbl_contains({ "d", "y", "g@" }, operator) then
    vim.print("Unimplemented operator " .. operator .. "!")
    return
  end

  local scope = MiniIndentscope.get_scope(nil, nil)
  for _ = 2, count1 do
    scope = MiniIndentscope.get_scope(scope.border.top, nil)
  end
  if scope.border.indent < 0 then
    return
  end

  local body = scope.body
  local border = scope.border
  local indent_change = body.indent - border.indent

  -- Functions like `nvim_buf_get_lines` are zero-based, so it's easier if our
  -- numbers are too
  body.top, body.bottom = body.top - 1, body.bottom - 1
  border.top, border.bottom = border.top - 1, border.bottom - 1

  -- Comment the surrounding lines
  -- Technically brittle because this could be a different operator - but fine
  -- for my purposes
  if operator == "g@" then
    require("vim._comment").toggle_lines(border.top, border.top)
    require("vim._comment").toggle_lines(border.bottom, border.bottom)
    return
  end

  local surrounding_lines = {
    unpack(vim.api.nvim_buf_get_lines(buf, border.top, border.top + 1, true)),
    unpack(vim.api.nvim_buf_get_lines(buf, border.bottom, border.bottom + 1, true)),
  }

  -- `vim.hl.on_yank` can't understand my selection - so perform the
  -- highlight myself!
  if operator == "y" then
    vim.hl.range(buf, ns, "IncSearch", { border.top, border.indent }, { border.top, -1 })
    vim.hl.range(buf, ns, "IncSearch", { border.bottom, border.indent }, { border.bottom, -1 })
    vim.defer_fn(function()
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      vim.fn.setreg(vim.v.register, table.concat(surrounding_lines, "\n"), "l")
    end, 150)
    return
  end

  -- Still yank the surrounding lines for `d`
  vim.fn.setreg(vim.v.register, table.concat(surrounding_lines, "\n"), "l")

  -- Deindent the lines we'll be keeping
  local inner_lines = vim.api.nvim_buf_get_lines(buf, body.top, body.bottom + 1, true)
  for i, line in ipairs(inner_lines) do
    local current_indent = vim.fn.indent(body.top + i)
    inner_lines[i] = vim.text.indent(current_indent - indent_change, line, { expandtab = 1 })
  end

  -- Replace the full range with the deindented new version
  vim._with({ lockmarks = true }, function()
    vim.api.nvim_buf_set_lines(buf, border.top, border.bottom + 1, true, inner_lines)
  end)

  -- Scheduling means this doesn't get accidentally deleted, since vim expects
  -- any cursor movement in operator mode to mean the operation you want to
  -- perform
  vim.schedule(function()
    local cursor_dedent = {
      math.max(1, row - (body.top - border.top)),
      math.max(0, col - indent_change),
    }
    vim.api.nvim_win_set_cursor(win, cursor_dedent)
  end)
end

-- Used for nvim-surround
Custom.get_indent_selections = function(linewise, count1)
  local scope = MiniIndentscope.get_scope(nil, nil)
  for _ = 2, count1 do
    scope = MiniIndentscope.get_scope(scope.border.top, nil)
  end
  if scope.border.indent < 0 then
    return
  end

  local border = scope.border
  local top_length = vim.fn.col({ border.top, "$" })
  local bottom_length = vim.fn.col({ border.bottom, "$" })

  -- We also include support for keeping the lines in the buffer, and just
  -- select the non-whitespace contents. This is used for `csi` (although I don't
  -- use it much)
  local left, right
  if linewise then
    left = {
      first_pos = { border.top, 1 },
      last_pos = { border.top + 1, 0 },
    }
    right = {
      first_pos = { border.bottom - 1, 0 },
      last_pos = { border.bottom, bottom_length - 1 },
    }
  else
    left = {
      first_pos = { border.top, border.indent + 1 },
      last_pos = { border.top, top_length - 1 },
    }
    right = {
      first_pos = { border.bottom, border.indent + 1 },
      last_pos = { border.bottom, bottom_length - 1 },
    }
  end

  return { left = left, right = right }
end
