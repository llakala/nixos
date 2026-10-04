local ns = vim.api.nvim_create_namespace("nvim.multicursor")

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
-- in follow mode, place a cursor before leaving
do
  vim.keymap.set("n", { "[C", "]C" }, "<Nop>")

  vim.keymap.set("n", "qh", function()
    if vim.o.follow then
      vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    end
    return "[C"
  end, { expr = true })
  vim.keymap.set("n", "ql", function()
    if vim.o.follow then
      vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    end
    return "]C"
  end, { expr = true })
end

do
  -- Toggle follow mode for a single motion
  -- mnemonic: f for follow
  vim.keymap.set({ "n", "x" }, "qf", function()
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function()
        vim.o.follow = not vim.o.follow
        return true
      end,
    })
    vim.o.follow = not vim.o.follow
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
  -- qx{motion}{motion}
  -- first motion selects the range to operate on
  -- second motion places a cursor on every instance of that motion (in the
  -- previous range)
  -- mnemonic: s for select
  vim.keymap.set("n", "qx", function()
    operator()
  end)
  vim.keymap.set("n", "qxx", function()
    operator("_")
  end)

  vim.keymap.set("x", "qx", function()
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

-- [cursor-count]qs[motion-count]{motion}
-- Examples:
-- 1. qs2w places a cursor "two words away"
-- 2. 2qsw places two cursors, one on each word
-- 3. 2qs2w places two cursors, one "two words away", one "four words away"
do
  vim.keymap.set("n", "qs", function()
    vim.b.cursor_before_operator = vim.api.nvim_win_get_cursor(0)
    local operator_count = vim.v.count1

    vim.api.nvim_create_autocmd("CmdAtom", {
      once = true,
      callback = function(ev)
        -- lhs preserves the motion count, and accounts for weird motions like /
        local motion = string.gsub(ev.data.lhs, "qs", "", 1)

        for _ = 0, operator_count do
          vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
          vim.cmd("norm " .. motion)
        end

        vim.api.nvim_win_set_cursor(0, vim.b.cursor_before_operator)
      end,
    })

    -- set cursor before CmdAtom to prevent flashing
    vim.o.operatorfunc = function()
      vim.api.nvim_win_set_cursor(0, vim.b.cursor_before_operator)
    end

    vim.o.follow = true
    return "g@"
  end, { expr = true })
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

    vim.o.operatorfunc = function(mode)
      local cursor = vim.b.cursor_before_operator
      local start_pos = vim.api.nvim_buf_get_mark(0, "[")
      local end_pos = vim.api.nvim_buf_get_mark(0, "]")
      if mode == "line" then
        start_pos[2] = 0
        end_pos[2] = #vim.fn.getline(end_pos[1])
      end

      -- place a cursor on each instance of cword (other than the current one)
      -- ignore matches before the start col / after the end col
      local matches = vim.fn.matchbufline("%", cword, start_pos[1], end_pos[1])
      for _, match in ipairs(matches) do
        local pos = { match.lnum, match.byteidx }
        if
          (pos[1] ~= cursor[1] or pos[2] ~= cursor[2])
          and (pos[1] ~= start_pos[1] or pos[2] >= start_pos[2])
          and (pos[1] ~= end_pos[1] or pos[2] <= end_pos[2])
        then
          vim.api.nvim_buf_set_extmark(0, ns, pos[1] - 1, pos[2])
        end
      end

      vim.api.nvim_win_set_cursor(0, cursor)
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
