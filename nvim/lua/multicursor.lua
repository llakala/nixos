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

-- "rotate" each cursor's visual selection with qn / qp
-- TODO:
-- 1. use the current normal-mode position for V
-- 2. obey [count]
-- 3. try to preserve undo
do
  local visual_ns = vim.api.nvim_create_namespace("nvim.multicursor.visual")

  local function rotate(forward)
    if vim.api.nvim__mcursor_cascading() then
      return
    end
    local visual_extmarks = vim.api.nvim_buf_get_extmarks(0, visual_ns, 0, -1, { details = true })
    if #visual_extmarks == 0 then
      return
    end

    -- `!` flag is needed to prevent https://github.com/neovim/neovim/issues/42263
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx!", false)

    local primary_start = vim.api.nvim_buf_get_mark(0, "<")
    local primary_end = vim.api.nvim_buf_get_mark(0, ">")
    if vim.fn.visualmode() == "V" then
      primary_end[2] = #vim.api.nvim_get_current_line() - 1
    end
    local primary_placed = false

    local cursors = {}
    for i, mark in ipairs(visual_extmarks) do
      local range = vim.range.extmark(0, mark[2], mark[3], mark[4].end_row, mark[4].end_col)
      local start_pos = vim.pos.extmark(0, mark[2], mark[3])
      cursors[i] = {
        range = range,
        text = vim.api.nvim_buf_get_text(0, range:to_extmark()),
        key = start_pos:to_offset(),
      }
      if vim.deep_equal(start_pos:to_cursor(), primary_start) then
        cursors[i].primary = true
        primary_placed = true
      end
    end

    --- if there's not a multicursor underneath the primary, add it to the list
    --- of cursors to be moved. Keeping the list sorted preserves our axioms
    --- about iterating backwards
    if not primary_placed then
      local range = vim.range.mark(0, primary_start[1], primary_start[2], primary_end[1], primary_end[2])
      local primary = {
        range = range,
        text = vim.api.nvim_buf_get_text(0, range:to_extmark()),
        key = vim.pos.cursor(0, primary_start):to_offset(),
        primary = true,
      }
      local index = vim.list.bisect(cursors, primary, { key = "key" })
      table.insert(cursors, index, primary)
    end

    -- delete all existing cursors, then rotate each cursor. rotations are
    -- applied in reverse buffer order, so rotations from previous cursors don't
    -- invalidate the ranges of later cursors
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    local iter = vim.iter(cursors)
    local prev = forward and iter:rpeek() or iter:peek()
    for cursor in iter:rev() do
      local next_cursor = forward and iter:peek() or prev
      if not forward then
        prev = cursor
      end
      local range = cursor.range
      vim.api.nvim_buf_set_text(0, range[1], range[2], range[3], range[4], next_cursor.text)
      if cursor.primary then
        vim.api.nvim_win_set_cursor(0, primary_start)
      else
        vim.api.nvim_buf_set_extmark(0, ns, range[1], range[2])
      end
    end
  end

  vim.keymap.set("x", "qn", function()
    rotate(true)
  end)
  vim.keymap.set("x", "qp", function()
    rotate(false)
  end)
end

do
  -- when `qf{motion}` is used to temporarily disable follow mode, if there's
  -- an extra multicursor underneath the main cursor  delete it
  -- more intuitive than leaving the multicursor there
  local function delete_multi_at_cursor()
    local cursor = vim.api.nvim_win_get_cursor(0)
    cursor[1] = cursor[1] - 1
    local extmarks = vim.api.nvim_buf_get_extmarks(0, ns, cursor, cursor, {})
    if #extmarks > 0 then
      vim.api.nvim_buf_del_extmark(0, ns, extmarks[1][1])
    end
  end

  -- Toggle follow mode for a single motion
  -- mnemonic: f for follow
  vim.keymap.set({ "n", "x" }, "qf", function()
    vim.api.nvim_create_autocmd("CmdAtom", {
      callback = function(ev)
        if ev.data.lhs == "qf" then
          return
        end
        vim.o.follow = not vim.o.follow
        return true
      end,
    })
    vim.o.follow = not vim.o.follow
    if not vim.o.follow then
      delete_multi_at_cursor()
    end
  end)

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

        -- note: doesn't play well with textobjects and omap bindings
        -- if we get https://github.com/neovim/neovim/issues/42228, then
        -- extmarks could be set in the operatorfunc itself
        for _ = 1, operator_count do
          vim.cmd("norm " .. motion)
          vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
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
      cword_start = vim.fn.getpos(".")
      cword = vim.fn.getregion(cword_start, cword_start)[1]
      if vim.fn.match(cword, [[\k]]) ~= -1 then
        is_keyword = true
        cword = vim.fn.expand("<cword>")
        cword = [[\C\V\<]] .. vim.fn.escape(cword, [[\]]) .. [[\>]]
      end
    end

    -- escape non-keyword so it can't execute regex
    if not is_keyword then
      cword = [[\C\V]] .. vim.fn.escape(cword, [[\]])
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
