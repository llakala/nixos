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
---@return table
local function get_matches(ctx, args, global)
  local buf = vim.api.nvim_get_current_buf()
  local matches = vim.fn.matchbufline(buf, args[2], ctx.line1, ctx.line2)

  if not global then
    local prev_line = nil
    matches = vim.tbl_filter(function(match)
      local new_lnum = match.lnum ~= prev_line
      prev_line = match.lnum
      return new_lnum
    end, matches)
  end

  return matches
end

vim.api.nvim_create_user_command("Place", function(ctx)
  local args, global = parse_args(ctx)
  if not args then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("nvim.multicursor")

  local matches = get_matches(ctx, args, global)
  if #matches == 0 then
    vim.api.nvim_echo({ { "E486: Pattern not found: " .. args[2] } }, true, { err = true })
    return
  end

  -- because of my issue, moving cursors now PLACES a cursor, but we don't want
  -- that here. place the cursor ourselves so we can get its id and delete it
  -- later
  local id = vim.api.nvim_mcursor(buf, vim.api.nvim_win_get_cursor(0))

  for _, match in ipairs(matches) do
    vim.api.nvim_mcursor(buf, { match.lnum, match.byteidx })
  end

  -- Move to the next cursor, then delete the cursor on the original pos
  -- TODO: fix bad edge cases. ideally core functions would be more extensible,
  -- so we could find the cursor that's closest from the current batch, and
  -- prevent placing on jump
  require("vim._core.mcursor").jump(true)
  vim.api.nvim_buf_del_extmark(buf, ns, id)
end, {
  range = true,
  -- Empty nargs means we should reuse last search pattern
  nargs = "?",
  preview = function(ctx, ns)
    local buf = vim.api.nvim_get_current_buf()
    local args, global = parse_args(ctx)
    if not args then
      return 0
    end

    local matches = get_matches(ctx, args, global)
    for _, match in ipairs(matches) do
      vim.hl.range(buf, ns, "Substitute", { match.lnum - 1, match.byteidx }, { match.lnum - 1, match.byteidx + 1 })
    end
    return 1
  end,
})
