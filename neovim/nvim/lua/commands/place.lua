---@param ctx vim.api.keyset.create_user_command.command_args
---@return table | nil, boolean
local function parse_args(ctx)
  local separator = string.sub(ctx.args, 1, 1)
  local global = false

  if separator:match('[%w\\"|]') ~= nil then
    -- See :h pattern-delimiter
    vim.api.nvim_echo({ { "E146: Invalid separator '" .. separator .. "'" } }, true, { err = true })
    return nil, false
  end

  -- Separator that doesn't have a backslash before it (negative lookbehind)
  local pattern = [[\\\@<!\]] .. separator
  local args = vim.fn.split(ctx.name .. ctx.args, pattern)

  if #args == 1 or args[2] == "" then
    -- Reuse the last search pattern
    args[2] = vim.fn.getreg("/")
  elseif #args > 3 then
    -- :Place/foo/g/baz
    local acc = table.concat(args, separator, 4)
    vim.api.nvim_echo({ { "E488: Trailing characters: " .. acc } }, true, { err = true })
    return nil, false
  else
    -- Write the search pattern for reuse
    vim.fn.setreg("/", args[2])
  end

  if args[3] ~= nil and args[3] ~= "" then
    if args[3] == "g" then
      global = true
    else
      vim.api.nvim_echo({ { "E488: Invalid flags: " .. args[3] } }, true, { err = true })
      return nil, false
    end
  end
  return args, global
end

---@param ctx vim.api.keyset.create_user_command.command_args
---@param args string[]
---@param global boolean
---@return vim.Iter
local function get_matches(ctx, args, global)
  local buf = vim.api.nvim_get_current_buf()
  local matches = vim.iter(vim.fn.matchbufline(buf, args[2], ctx.line1, ctx.line2))

  if not global then
    local prev_lnum = nil
    matches:filter(function(match)
      local is_new_lnum = match.lnum ~= prev_lnum
      prev_lnum = match.lnum
      return is_new_lnum
    end)
  end

  return matches:map(function(match)
    return vim.pos.cursor(0, { match.lnum, match.byteidx })
  end)
end

vim.api.nvim_create_user_command("Place", function(ctx)
  local args, global = parse_args(ctx)
  if not args then
    return
  end

  local matches = get_matches(ctx, args, global)
  local first_match = matches:peek()
  if first_match == nil then
    vim.api.nvim_echo({ { "E486: Pattern not found: " .. args[2] } }, true, { err = true })
    return
  end

  local curpos = vim.pos.cursor(0)
  local cursor_placed = false
  for match in matches do
    -- place cursor on the first match that's after the cursor
    if not cursor_placed and match > curpos then
      vim.api.nvim_win_set_cursor(0, match:to_cursor())
      cursor_placed = true
    end
    vim.api.nvim_mcursor(0, match:to_cursor())
  end

  -- if the cursor never got placed, it must've been after every match -
  -- loop around to the beginning
  if not cursor_placed then
    vim.api.nvim_win_set_cursor(0, first_match:to_cursor())
  end
end, {
  range = true,
  -- Empty nargs means we should reuse last search pattern
  nargs = "?",
  preview = function(ctx, ns)
    local args, global = parse_args(ctx)
    if not args then
      return 0
    end

    local matches = get_matches(ctx, args, global)
    for match in matches do
      vim.hl.range(0, ns, "Substitute", { match.row, match.col }, { match.row, match.col + 1 })
    end
    return 1
  end,
})
