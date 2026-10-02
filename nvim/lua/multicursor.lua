local ns = vim.api.nvim_create_namespace("nvim.multicursor")

do
  -- Q without a count places a cursor (unchanged)
  -- {count}Q places [count] cursors, one on each line, and enables follow mode
  vim.keymap.set("n", "Q", function()
    local keys = ""
    if vim.v.count1 == 1 then
      -- fallback to normal Q
      keys = "Q"
    else
      keys = string.rep("Q", vim.v.count1, "j") .. "q="
    end
    vim.api.nvim_feedkeys(keys, "nx", false)
  end)
end

-- q will be the new leader for everything multicursor-related
-- move everything macro-related to +, -, and _
do
  vim.keymap.set({ "n", "x" }, "q", "<Nop>")

  -- Create a macro
  -- mnemonic: "adds" a new mapping
  vim.keymap.set({ "n", "x" }, "+", function()
    if vim.fn.reg_recording() ~= "" then
      return "q"
    end
    local char = vim.fn.getcharstr()
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

  -- I have @ as linewise mini.comment
  vim.keymap.set("n", "_", "@")
  vim.keymap.set("x", "_", "mode() ==# 'V' ? ':normal! @'.getcharstr().'<CR>' : '@'", { silent = true, expr = true })
  vim.keymap.set("n", "__", "@@")

  -- Create commandline window
  vim.keymap.set({ "n", "x" }, "g/", "q/")
  vim.keymap.set({ "n", "x" }, "g?", "q?")
  vim.keymap.set({ "n", "x" }, "g:", "q:")
end

-- move between cursors with qh / ql
-- to purely jump and not place a cursor upon leaving, use qH and qL
do
  vim.keymap.set("n", { "[C", "]C" }, "<Nop>")

  vim.keymap.set("n", "qh", "[C")
  vim.keymap.set("n", "ql", "]C")

  vim.keymap.set("n", "qH", function()
    vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    return "[C"
  end, { expr = true })
  vim.keymap.set("n", "qL", function()
    vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    return "]C"
  end, { expr = true })
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
do
  local last_ns = vim.api.nvim_create_namespace("nvim.multicursor.last")
  vim.keymap.set({ "n", "x" }, "qu", function()
    -- don't move the primary cursor
    pcall(vim.api.nvim_buf_del_extmark, 0, last_ns, 1)
    return "gQ"
  end, { expr = true })
  vim.keymap.set({ "n", "x" }, "gQ", "<Nop>")
end

do
  local function operator(motion)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.go.operatorfunc = function(type)
      local key
      if type == "line" then
        key = "V"
      elseif type == "block" then
        key = vim.keycode("<C-v>")
      else
        key = "v"
      end

      local range_start = vim.api.nvim_buf_get_mark(0, "[")
      local range_end = vim.api.nvim_buf_get_mark(0, "]")
      if cursor[1] <= range_start[1] then
        range_start, range_end = range_end, range_start
      end

      vim.api.nvim_win_set_cursor(0, range_start)
      vim.api.nvim_feedkeys(key, "nx", false)
      vim.api.nvim_win_set_cursor(0, range_end)

      vim.api.nvim_create_autocmd("CmdAtom", {
        callback = function()
          vim.cmd("silent! normal! 1q=")
          return true
        end,
      })
      vim.api.nvim_feedkeys("zq", "n", false)
    end
    vim.api.nvim_feedkeys("g@" .. (motion or ""), "in", false)
  end
  -- qs{motion}{motion}
  -- first motion selects the range to operate on
  -- second motion places a cursor on every instance of that motion (in the
  -- previous range)
  -- mnemonic: s for select
  vim.keymap.set("n", "qs", function()
    operator()
  end)
  vim.keymap.set("n", "qss", function()
    operator("_")
  end)

  vim.keymap.set("x", "qs", function()
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function()
        vim.cmd("silent! normal! 1q=")
        return true
      end,
    })
    return "zq"
  end, { expr = true })

  vim.keymap.set({ "n", "x" }, "zq", "<Nop>")
end

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
      vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
      vim.cmd("silent keepjumps normal! " .. (forward and "n" or "N"))
    end
    -- Place cursor on final instance
    vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())

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

-- Operator that places a cursor on all instances of <cword> in the
-- motion's range
do
  local function operator(visual, motion)
    local cword, cword_start, cword_end, is_keyword

    if visual then
      -- get current visual selection as cword
      cword_start, cword_end = vim.fn.getpos("v"), vim.fn.getpos(".")
      cword = vim.fn.getregion(cword_start, cword_end)[1]
    else
      -- if current character is special, use it. otherwise, expand <cword>
      -- not
      cword_start = vim.fn.getpos(".")
      cword = vim.fn.getregion(cword_start, cword_start)[1]
      if vim.fn.match(cword, [[\k]]) ~= -1 then
        is_keyword = true
        cword = vim.fn.expand("<cword>")
        cword = [[\V\<]] .. vim.fn.escape(cword, [[\]]) .. [[\>]]
      end
    end

    -- escape non-keyword so it can't execute regex
    if not is_keyword then
      cword = [[\V]] .. vim.fn.escape(cword, [[\]])
    end

    vim.go.operatorfunc = function(mode)
      local range_start = vim.api.nvim_buf_get_mark(0, "[")
      local range_end = vim.api.nvim_buf_get_mark(0, "]")
      if mode == "line" then
        range_start[2] = 0
        range_end[2] = #vim.fn.getline(range_end[1])
      end

      -- place a cursor on each instance of cword, ignoring matches before the
      -- start col / after the end col
      local matches = vim.fn.matchbufline("%", cword, range_start[1], range_end[1])
      for _, match in ipairs(matches) do
        if
          (match[1] ~= range_start[1] or match[2] >= range_start[2])
          and (match[1] ~= range_end[1] or match[2] <= range_end[2])
        then
          vim.api.nvim_buf_set_extmark(0, ns, match.lnum - 1, match.byteidx)
        end
      end
      vim.api.nvim_win_set_cursor(0, vim.b.cursor_before_operator)
    end

    -- when exiting visual mode, store the final cursor position in the variable
    -- that's also set on dot repeat
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "v:*",
      callback = function()
        vim.b.cursor_before_operator = vim.api.nvim_buf_get_mark(0, "<")
        -- delete autocmd
        return true
      end,
    })

    if visual then
      -- < mark is already be in the right place
      return "<Esc>1q=g@" .. (motion or "")
    elseif is_keyword then
      -- place the < mark at the start of cword
      return "viwo<Esc>1q=g@" .. (motion or "")
    end
    -- searching special character, place < on curpos
    return "v<Esc>1q=g@" .. (motion or "")
  end

  vim.keymap.set("n", "qr", function()
    return operator(false, "")
  end, { expr = true })
  vim.keymap.set("n", "qrr", function()
    return operator(false, "_")
  end, { expr = true })
  vim.keymap.set("x", "qr", function()
    return operator(true, "")
  end, { expr = true })
  vim.keymap.set("x", "qrr", function()
    return operator(true, "_")
  end, { expr = true })
end

do
  vim.api.nvim_set_hl(0, "MCursor", { bg = "#aaaaaa" })
end
