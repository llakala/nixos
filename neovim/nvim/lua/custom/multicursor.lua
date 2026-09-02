local M = {}

local mc = vim.api.nvim_create_namespace("nvim.multicursor")

local function place_cursor_at_curpos()
  vim.api.nvim_mcursor(0, vim.api.nvim_win_get_cursor(0))
end

local function place_cursors_at_searches()
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
      if not vim.v.event.abort then
        vim.api.nvim_feedkeys("1Q", "n", true)
      end
      return true
    end,
  })
end

local function apply_simple_mappings()
  -- Move to next/previous cursor, and place a cursor at current position (if
  -- unset)
  vim.keymap.set("n", "[c", function()
    place_cursor_at_curpos()
    return "[C"
  end, { expr = true })
  vim.keymap.set("n", "]c", function()
    place_cursor_at_curpos()
    return "]C"
  end, { expr = true })

  -- Unmap defaults
  vim.keymap.set("n", "[C", "<Nop>")
  vim.keymap.set("n", "]C", "<Nop>")

  -- Move to next/previous change (h for hunk)
  vim.keymap.set("n", "[h", "[c")
  vim.keymap.set("n", "]h", "]c")

  -- toggle follow mode.
  -- TODO: find a way to unmap q= without delay
  vim.keymap.set("n", "gz", "q=")

  -- Bring back all cursors after removing them
  vim.keymap.set("n", "gZ", "gQ")
  vim.keymap.set("n", "gQ", "<Nop>")
end

local function apply_complex_mappings()
  -- bring back "replay last macro" on Q
  vim.keymap.set("n", "Q", function()
    local reg = vim.fn.reg_recorded()
    return reg == "" and "" or ("@" .. reg)
  end, { expr = true })
  vim.keymap.set(
    "x",
    "Q",
    "mode() ==# 'V' ? ':normal! @<C-R>=reg_recorded()<CR><CR>' : ''",
    { expr = true, silent = true }
  )

  -- Z to create a cursor
  vim.keymap.set({ "n", "x" }, "Z", "Q")

  -- if multicursor, `z` prefixes a motion and applies it to all cursors
  -- if one cursor, z works as normal
  vim.keymap.set("n", "z", function()
    if #vim.api.nvim_buf_get_extmarks(0, mc, 0, -1, { limit = 1 }) == 0 then
      return "z"
    end
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function(ev)
        if ev.data.lhs == "z" then
          return
        end
        vim.cmd("silent! normal! 2q=")
        -- delete self
        return true
      end,
    })
    return "<Cmd>silent! norm! 1q=<CR>"
  end, { expr = true })

  -- Search and place cursors on every search result
  vim.keymap.set("n", "z/", function()
    place_cursors_at_searches()
    return "/"
  end, { expr = true })
  vim.keymap.set("x", "z/", function()
    place_cursors_at_searches()
    return "<Esc>/\\%V"
  end, { expr = true })
end

local function change_kitty_cursor_hl()
  -- Set the SRGB color of all other cursors. Needs to be done manually if your
  -- terminal implements the kitty multiple-cursors protocol
  -- TODO: reset the colors when leaving nvim
  -- See https://github.com/neovim/neovim/issues/41603
  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      vim.api.nvim_ui_send("\027[>40;2:170:170:170 q")
    end,
  })
end

M.setup = function()
  apply_simple_mappings()
  apply_complex_mappings()
  change_kitty_cursor_hl()
end

return M
