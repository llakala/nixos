-- ]C and [C are annoying to type by default
do
  vim.keymap.set("n", "[c", "[C")
  vim.keymap.set("n", "]c", "]C")
  vim.keymap.set("n", "[C", "<Nop>")
  vim.keymap.set("n", "]C", "<Nop>")

  -- Move to next/previous change
  -- mnemonic: h for hunk
  vim.keymap.set("n", "[h", "[c")
  vim.keymap.set("n", "]h", "]c")
end

-- q will be the new leader for everything multicursor-related
-- move things currently under it elsewhere
do
  vim.keymap.set({ "n", "x" }, "q", "<Nop>")

  -- Create a macro
  -- mnemonic: "adds" a new mapping
  vim.keymap.set({ "n", "x" }, "+", function()
    if vim.fn.reg_recording() ~= "" then
      return "q"
    end
    local char = vim.fn.getcharstr()
    vim.print(char)
    if char == "+" then
      return "qq"
    end
    return "q" .. char
  end, { expr = true })
  --
  -- Replay last macro
  vim.keymap.set("n", "-", function()
    local reg = vim.fn.reg_recorded()
    return reg == "" and "" or ("@" .. reg)
  end, { expr = true })
  vim.keymap.set(
    "x",
    "-",
    "mode() ==# 'V' ? ':normal! @<C-R>=reg_recorded()<CR><CR>' : ''",
    { expr = true, silent = true }
  )

  -- Create commandline window
  vim.keymap.set({ "n", "x" }, "g/", "q/")
  vim.keymap.set({ "n", "x" }, "g?", "q?")
  vim.keymap.set({ "n", "x" }, "g:", "g:")
end

do
  -- Enable follow mode for a single motion
  -- mnemonic: f for follow
  vim.keymap.set({ "n", "x" }, "qf", function()
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function(ev)
        if ev.data.lhs == "qf" then
          return
        end
        vim.cmd("silent! normal! 2q=")
        -- delete self
        return true
      end,
    })
    return "<Cmd>silent! norm! 1q=<CR>"
  end, { expr = true })

  -- Enable/disable follow mode
  vim.keymap.set({ "n", "x" }, "qF", "q=")
end

-- Bring back all cursors after removing them
-- mnemonic: u for undo
vim.keymap.set({ "n", "x" }, "qu", "gQ")
vim.keymap.set({ "n", "x" }, "gQ", "<Nop>")

-- Place a cursor at the start of <cword>, then move to the next instance
do
  local function place_and_jump(forward)
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
    -- Also puts initial pos in jumplist and sets slash buffer
    vim.v.errmsg = ""
    vim.api.nvim_feedkeys("*", "nx", false)
    if vim.v.errmsg ~= "" then
      cleanup()
      return
    end
    vim.cmd("silent keepjumps normal! N")

    for _ = 1, count do
      vim.api.nvim_mcursor(0, vim.api.nvim_win_get_cursor(0))
      vim.cmd("silent keepjumps normal! " .. (forward and "*" or "#"))
    end
    -- Place cursor on final instance
    vim.api.nvim_mcursor(0, vim.api.nvim_win_get_cursor(0))

    cleanup()
  end

  -- TODO: support visual mode
  vim.keymap.set("n", "q*", function()
    place_and_jump(true)
  end)
  vim.keymap.set("n", "q#", function()
    place_and_jump(false)
  end)
end

do
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
