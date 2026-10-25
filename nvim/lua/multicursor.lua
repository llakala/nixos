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
  vim.keymap.set({ "n", "o" }, { "[C", "]C" }, "<Nop>")

  vim.keymap.set({ "n", "o" }, "qh", function()
    if vim.o.follow then
      vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    end
    return "[C"
  end, { expr = true })
  vim.keymap.set({ "n", "o" }, "ql", function()
    if vim.o.follow then
      vim.api.nvim_buf_set_extmark(0, ns, vim.pos.cursor(0):to_extmark())
    end
    return "]C"
  end, { expr = true })
end

-- "rotate" each cursor's visual selection with qn / qp
do
  ---@class (exact) CursorMeta
  ---@field range vim.Range
  ---@field text string[]
  ---@field start_offset integer
  ---@field cursor_offset integer
  ---@field primary boolean?

  local cursor_ns = vim.api.nvim_create_namespace("nvim.multicursor.cursor")
  local visual_ns = vim.api.nvim_create_namespace("nvim.multicursor.visual")

  ---@param cursors CursorMeta[]
  local function apply_rotation(cursors, primary_placed, distance)
    -- Applies rotations in reverse buffer order, so previous cursors don't
    -- invalidate the ranges of later cursors
    for i = #cursors, 1, -1 do
      local cursor = cursors[i]
      local range = cursor.range
      local next_cursor = cursors[(i - distance - 1) % #cursors + 1]
      vim.api.nvim_buf_set_text(0, range[1], range[2], range[3], range[4], next_cursor.text)

      local pos
      if
        next_cursor.cursor_offset < next_cursor.start_offset
        or next_cursor.cursor_offset > (next_cursor.start_offset + #next_cursor.text)
      then
        -- next cursor is outside of its range, ignore its offset
        pos = vim.pos.offset(0, cursor.start_offset)
      else
        pos = vim.pos.offset(0, cursor.start_offset + next_cursor.cursor_offset - next_cursor.start_offset)
      end

      -- Preserve whether there was a multicursor underneath the primary
      if not cursor.primary or primary_placed then
        vim.api.nvim_buf_set_extmark(0, ns, pos:to_extmark())
      end
      if cursor.primary then
        vim.api.nvim_win_set_cursor(0, pos:to_cursor())
      end
    end
  end

  local function rotate_normal(forward, motion, info)
    if vim.v.cascading then
      return
    end
    local primary_pos = vim.pos.cursor(0)
    local normal_extmarks = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1)
    if #normal_extmarks == 0 then
      return
    end

    vim.async.run(function()
      -- on dot repeat, reuse the cached info. otherwise, get the motion keys
      -- via a CmdAtom
      if not info then
        info = {}
        info.count = vim.v.count1
        vim.async.await(function(finish)
          -- dummy operatorfunc
          vim.o.operatorfunc = function(op_type)
            vim.api.nvim_win_set_cursor(0, primary_pos:to_cursor())
            info.optype = op_type
          end

          vim.api.nvim_create_autocmd("CmdAtom", {
            once = true,
            callback = function(ev)
              info.keys = ev.data.keys
              finish()
            end,
          })

          vim.api.nvim_feedkeys("g@" .. (motion or ""), "ni", false)
        end)
      end

      ---@type CursorMeta[]
      local cursors = {}
      local primary_placed = false
      local primary_start = vim.api.nvim_buf_get_mark(0, "[")
      local primary_end = vim.api.nvim_buf_get_mark(0, "]")
      local distance = (forward and 1 or -1) * info.count

      -- await all the operators finishing, so the `cursors` table is fully
      -- populated. by queueing all the operator calls eagerly with
      -- nvim_feedkeys, the cursors are placed in a single visual refresh!
      vim.async.await(function(finish)
        ---@type vim.Pos[]
        local cursor_positions = {}
        local op_index = 1

        vim.o.operatorfunc = function()
          local cursor_pos = cursor_positions[op_index]
          local range_start = vim.api.nvim_buf_get_mark(0, "[")
          local range_end = vim.api.nvim_buf_get_mark(0, "]")
          if info.optype == "line" then
            range_start[2] = 0
            range_end[2] = #vim.fn.getline(range_end[1]) - 1
          end
          local range = vim.range.mark(0, range_start[1], range_start[2], range_end[1], range_end[2])

          ---@type CursorMeta
          local cursor = {
            range = range,
            text = vim.api.nvim_buf_get_text(0, range:to_extmark()),
            start_offset = vim.pos.cursor(0, range_start):to_offset(),
            cursor_offset = cursor_pos:to_offset(),
          }

          if cursor_pos == primary_pos then
            cursor.primary = true
            primary_placed = true
          end

          cursors[op_index] = cursor
          op_index = op_index + 1
          if op_index > #normal_extmarks then
            finish()
          end
        end

        -- since we don't have access to each cursor's marks, emit a faux-cascade
        -- ourselves
        for i, mark in ipairs(normal_extmarks) do
          local start_pos = vim.pos.extmark(0, mark[2], mark[3])
          vim.api.nvim_win_set_cursor(0, start_pos:to_cursor())
          cursor_positions[i] = start_pos
          vim.api.nvim_feedkeys(info.keys, "nx", false)
        end
      end)

      -- if there's not already a multicursor under the primary, insert it to the
      -- sorted list of cursors
      if not primary_placed then
        if info.optype == "line" then
          primary_start[2] = 0
          primary_end[2] = #vim.fn.getline(primary_end[1]) - 1
        end
        local range = vim.range.mark(0, primary_start[1], primary_start[2], primary_end[1], primary_end[2])

        ---@type CursorMeta
        local primary = {
          range = range,
          text = vim.api.nvim_buf_get_text(0, range:to_extmark()),
          start_offset = vim.pos.cursor(0, primary_start):to_offset(),
          cursor_offset = primary_pos:to_offset(),
          primary = true,
        }

        local index = vim.list.bisect(cursors, primary, {
          ---@param cursor CursorMeta
          key = function(cursor)
            return cursor.start_offset
          end,
        })
        table.insert(cursors, index, primary)
      end

      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      apply_rotation(cursors, primary_placed, distance)

      -- on dot repeat, re-call the function, caching the optype and keys
      vim.o.operatorfunc = function()
        rotate_normal(forward, motion, info)
      end
    end)
  end

  local function rotate_visual(forward)
    if vim.v.cascading then
      return
    end

    local cursor_extmarks = vim.api.nvim_buf_get_extmarks(0, cursor_ns, 0, -1)
    local visual_extmarks = vim.api.nvim_buf_get_extmarks(0, visual_ns, 0, -1, { details = true })
    if #visual_extmarks == 0 then
      return
    end

    local distance = (forward and 1 or -1) * vim.v.count1
    -- `!` flag is needed to prevent https://github.com/neovim/neovim/issues/42263
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx!", false)
    local primary_start = vim.api.nvim_buf_get_mark(0, "<")
    local primary_end = vim.api.nvim_buf_get_mark(0, ">")

    ---@type CursorMeta[]
    local cursors = {}
    local primary_placed = false
    for i, mark in ipairs(visual_extmarks) do
      local cursor_pos = vim.pos.extmark(0, cursor_extmarks[i][2], cursor_extmarks[i][3])
      local range_start = vim.pos.extmark(0, mark[2], mark[3])
      local range_end = vim.pos.extmark(0, mark[4].end_row, mark[4].end_col)
      ---@type vim.Range
      local range = vim.range(range_start, range_end)

      ---@type CursorMeta
      local cursor = {
        range = range,
        text = vim.api.nvim_buf_get_text(0, range:to_extmark()),
        start_offset = range_start:to_offset(),
        cursor_offset = cursor_pos:to_offset(),
      }
      if range_start == primary_start then
        cursor.primary = true
        primary_placed = true
      end

      cursors[i] = cursor
    end

    --- if there's not a multicursor underneath the primary, add it to the list
    --- of cursors to be moved. Keeping the list sorted preserves our axioms
    --- about iterating backwards
    if not primary_placed then
      local cursor_pos = vim.pos.cursor(0)
      if vim.fn.visualmode() == "V" then
        primary_end[2] = #vim.fn.getline(primary_end[1]) - 1
      end
      local primary_range = vim.range.mark(0, primary_start[1], primary_start[2], primary_end[1], primary_end[2])

      local primary = {
        range = primary_range,
        text = vim.api.nvim_buf_get_text(0, primary_range:to_extmark()),
        start_offset = vim.pos.cursor(0, primary_start):to_offset(),
        cursor_offset = cursor_pos:to_offset(),
        primary = true,
      }

      local index = vim.list.bisect(cursors, primary, {
        ---@param cursor CursorMeta
        key = function(cursor)
          return cursor.start_offset
        end,
      })
      table.insert(cursors, index, primary)
    end

    -- delete all existing cursors, then rotate each cursor
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    apply_rotation(cursors, primary_placed, distance)
  end

  vim.keymap.set("n", "qn", function()
    rotate_normal(true)
  end)
  vim.keymap.set("n", "qp", function()
    rotate_normal(false)
  end)
  vim.keymap.set("n", "qnn", function()
    rotate_normal(true, "_")
  end)
  vim.keymap.set("n", "qpp", function()
    rotate_normal(false, "_")
  end)

  vim.keymap.set("x", "qn", function()
    rotate_visual(true)
  end)
  vim.keymap.set("x", "qp", function()
    rotate_visual(false)
  end)
end

do
  -- when disabling follow mode, if there's an extra multicursor underneath the
  -- main cursor  delete it. more intuitive than leaving the multicursor there
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
  vim.keymap.set({ "n", "x" }, "qF", function()
    vim.o.follow = not vim.o.follow
    if not vim.o.follow then
      delete_multi_at_cursor()
    end
  end)
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
    vim.go.operatorfunc = function(optype)
      local key
      if optype == "line" then
        key = "V"
      elseif optype == "block" then
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
-- Mnemonic: "quick select"
--
-- Examples:
-- 1. qs2w places a cursor "two words away"
-- 2. 2qsw places two cursors, one on each word
-- 3. 2qs2w places two cursors, one "two words away", one "four words away"
--
-- NOTE:
-- This uses v:inclusive, which I patch into Neovim via wrappers/neovim/patches/inclusive.patch.
-- This lets me properly handle inclusive motions like `e` and `f`. I have an
-- older version that doesn't require this patch
-- [here](https://github.com/llakala/nixos/blob/0277f6434cfc26130f069654db21e0d49eb3f480/nvim/lua/multicursor.lua#L262-L298),
-- and I'll PR v:inclusive back to Neovim at some point
do
  vim.keymap.set("n", "qs", function()
    local operator_count = vim.v.count1
    vim.b.cursor_before_operator = vim.api.nvim_win_get_cursor(0)

    -- dummy operatorfunc, just used to setup a CmdAtom so we can repeat the
    -- call to the operator [count] times
    -- setting the position here prevents flashing
    vim.o.operatorfunc = function()
      vim.api.nvim_win_set_cursor(0, vim.b.cursor_before_operator)
    end

    vim.api.nvim_create_autocmd("CmdAtom", {
      once = true,
      callback = function(ev)
        -- place a multicursor on the other end of the motion
        vim.o.operatorfunc = function(optype)
          local mark = vim.api.nvim_buf_get_mark(0, "[")
          local cursor = vim.b.cursor_before_operator

          if cursor[1] == mark[1] and cursor[2] == mark[2] then
            mark = vim.api.nvim_buf_get_mark(0, "]")
            -- increment cursor column on exclusive selection
            if optype == "char" and not vim.v.inclusive then
              mark[2] = mark[2] + 1
            end
          else
            vim.api.nvim_win_set_cursor(0, vim.b.cursor_before_operator)
          end

          vim.api.nvim_buf_set_extmark(0, ns, mark[1] - 1, mark[2])
        end

        -- call the operatorfunc with the same motion typed by the user
        -- 3qs2w -> g@2w, 2g@2w, 3g@2w
        -- count multiplies with the motion count, so 2g@2w places a cursor four
        -- words ahead
        local operator = string.gsub(ev.data.lhs, "qs", "g@", 1)
        for count = 1, operator_count do
          vim.cmd("norm " .. count .. operator)
        end
      end,
    })

    vim.o.follow = true
    return "g@"
  end, { expr = true })
end

-- qd{motion} / v_qd{motion}
-- Mnemonic: "quick do"
-- Place a cursor on all instances of the current word / visual selection in the
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
        end_pos[2] = #vim.fn.getline(end_pos[1]) - 1
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

  vim.keymap.set("n", "qd", function()
    return operator(false, "")
  end, { expr = true })
  vim.keymap.set("n", "qdd", function()
    return operator(false, "_")
  end, { expr = true })
  vim.keymap.set("x", "qd", function()
    return operator(true, "")
  end, { expr = true })
  vim.keymap.set("x", "qdd", function()
    return operator(true, "_")
  end, { expr = true })
end

do
  vim.api.nvim_set_hl(0, "MCursor", { bg = "#aaaaaa" })
end
