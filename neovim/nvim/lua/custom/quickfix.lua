local M = {}

-- upon opening the qflist / loclist, jump to the entry that directly precedes the cursor.
M.jump_to_nearest_entry = function()
  local cursor = vim.pos.cursor(0):to_offset()

  vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
      if vim.bo.buftype ~= "quickfix" then
        return true
      end

      local closest = { lnum = -1, dist = math.huge }
      for i, loc in ipairs(vim.fn.getloclist(0)) do
        -- decrement col, since getloclist is 1-1 indexed
        local dist = cursor - vim.pos.mark(loc.bufnr, loc.lnum, loc.col - 1):to_offset()

        if dist >= 0 and dist < closest.dist then
          closest = { dist = dist, lnum = i }
        end
      end

      if closest.lnum ~= -1 then
        vim.schedule(function()
          vim.api.nvim_win_set_cursor(0, { closest.lnum, 0 })
        end)
      end

      -- delete autocmd
      return true
    end,
  })
end

return M
