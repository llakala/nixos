local M = {}

local function apply_simple_remaps()
  vim.keymap.set("n", "[c", "[C")
  vim.keymap.set("n", "]c", "]C")
  vim.keymap.set("n", "[C", "<Nop>")
  vim.keymap.set("n", "]C", "<Nop>")

  -- Move to next/previous change (h for hunk)
  vim.keymap.set("n", "[h", "[c")
  vim.keymap.set("n", "]h", "]c")

  -- Bring back all cursors after removing them
  vim.keymap.set("n", "q-", "gQ")
  vim.keymap.set("n", "gQ", "<Nop>")
end

local function apply_complex_mappings()
  -- `q` prefixes a motion and applies it to all cursors
  vim.keymap.set("n", "q", function()
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function(ev)
        if ev.data.lhs == "q" then
          return
        end
        vim.cmd("silent! normal! 2q=")
        -- delete self
        return true
      end,
    })
    return "<Cmd>silent! norm! 1q=<CR>"
  end, { expr = true })
  vim.keymap.set("n", "zq", "q")

  -- bring back "replay last macro"
  vim.keymap.set("n", "zQ", function()
    local reg = vim.fn.reg_recorded()
    return reg == "" and "" or ("@" .. reg)
  end, { expr = true })
  vim.keymap.set(
    "x",
    "zQ",
    "mode() ==# 'V' ? ':normal! @<C-R>=reg_recorded()<CR><CR>' : ''",
    { expr = true, silent = true }
  )

  local function place_and_jump(forward)
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()

    -- Disable hlsearch while iterating
    local search_hl = vim.api.nvim_get_hl(0, { name = "Search" })
    local cursearch_hl = vim.api.nvim_get_hl(0, { name = "CurSearch" })
    vim.api.nvim_set_hl(0, "Search", { link = "None" })
    vim.api.nvim_set_hl(0, "CurSearch", { link = "None" })

    local function cleanup()
      vim.cmd.nohlsearch()
      vim.api.nvim_set_hl(0, "Search", search_hl)
      vim.api.nvim_set_hl(0, "CurSearch", cursearch_hl)
    end

    -- Store this before feedkeys to prevent it from being invalidated
    local count = vim.v.count1

    -- Move to the beginning of cword before starting the iteration.
    -- Also puts start pos in jumplist, and sets slash buffer
    vim.v.errmsg = ""
    vim.cmd("normal! *")
    if vim.v.errmsg ~= "" then
      cleanup()
      return
    end
    vim.cmd("silent keepjumps normal! N")

    for _ = 1, count, 1 do
      vim.api.nvim_mcursor(buf, vim.api.nvim_win_get_cursor(win))
      vim.cmd("silent keepjumps normal! " .. (forward and "*" or "#"))
    end
    -- Place cursor on final instance
    vim.api.nvim_mcursor(buf, vim.api.nvim_win_get_cursor(win))

    cleanup()
  end

  vim.keymap.set("n", "q*", function()
    place_and_jump(true)
  end)
  vim.keymap.set("n", "q#", function()
    place_and_jump(false)
  end)
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
  apply_simple_remaps()
  apply_complex_mappings()
  change_kitty_cursor_hl()
end

return M
