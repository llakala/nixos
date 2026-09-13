local M = {}

-- upon opening the qflist, jump to the closest entry
-- recommended to be called inside a gO mapping
M.jump_to_nearest_entry = function()
  local cursor = vim.pos.cursor(0):to_offset()

  vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
      if vim.bo.buftype ~= "quickfix" then
        return true
      end

      local closest = { index = -1, offset = math.huge }
      for i, loc in ipairs(vim.fn.getloclist(0)) do
        -- decrement col, since getloclist is 1-1 indexed
        local offset = cursor - vim.pos.mark(loc.bufnr, loc.lnum, loc.col - 1):to_offset()

        -- find the element closest to the cursor (but not after it)
        if offset <= closest.offset and offset >= 0 then
          closest = { offset = offset, index = i }
        end
      end

      if closest.index ~= -1 then
        vim.schedule(function()
          vim.api.nvim_win_set_cursor(0, { closest.index, 0 })
        end)
      end

      -- delete autocmd
      return true
    end,
  })
end

return M
