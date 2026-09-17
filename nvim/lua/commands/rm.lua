local function print_error(message)
  vim.api.nvim_echo({ { message } }, true, { err = true })
end
local function remove_current_buffer(bang)
  if vim.o.modified then
    if bang then
      vim.cmd("silent write")
    else
      print_error("E37: No write since last change (add ! to override)")
      return
    end
  end

  vim.cmd.bdelete()
end

local function remove_other_buffer(filename, bufnr, bang)
  if bufnr == -1 then
    return
  end

  if vim.bo[bufnr].modified then
    if bang then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("silent write")
      end)
    else
      print_error('E162: No write since last change for buffer "' .. filename .. '" (add ! to override)')
      return
    end
  end

  vim.api.nvim_buf_delete(bufnr, {})
end

-- Remove file and delete buffer if it exists
-- With no arguments, this uses the current file and buffer. Pass an argument to
-- delete another file
vim.api.nvim_create_user_command("Remove", function(ctx)
  local filename
  if #ctx.fargs == 0 then
    filename = vim.fn.expand("%")
    remove_current_buffer(ctx.bang)
  else
    filename = ctx.fargs[1]
    local bufnr = vim.fn.bufnr(filename)
    remove_other_buffer(filename, bufnr, ctx.bang)
  end

  local stat, err = vim.uv.fs_stat(filename)
  if not stat then
    print_error(err)
  elseif not vim.uv.fs_access(filename, "W") then
    print_error('File "' .. filename .. "\" can't be written to")
  elseif stat.type ~= "file" then
    print_error('Path "' .. filename .. '" was expected to be a file, but was a ' .. stat.type)
  else
    vim.fs.rm(filename)
  end
end, { bang = true, nargs = "?", complete = "file" })

cabbrev("rm", "Remove")
