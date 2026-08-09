-- Core code logic from https://github.com/nathanmsmith/.config/blob/f8abcc3a0a4e81424cd27bdab5d947c0edfa9d1b/nvim/lua/marks.lua#L1
-- Modified to fit my purposes, match my code aesthetics, and remove features I
-- didn't use.
--
-- Renders marks when loading a buffer, and adds mark deletion keybinds (dma to
-- delete mark a, dM to delete all marks). Uses the nightly 0.12 MarkSet autocmd
-- (which was added by nathanmsmith, ty!)
local M = {}

M.config = {
  priority = 100,
  sign_group = "MarkSign",
  name_prefix = "MarkSign_",
}

function M.place_mark(bufnr, mark, lnum)
  local name = M.config.name_prefix .. mark
  local id = mark:byte()

  if mark:match("[A-Z]") then
    -- Unplace all global marks with this label, even in other buffers
    vim.fn.sign_unplace(M.config.sign_group, { id = id })
    if lnum == 0 then
      return
    end
    vim.fn.sign_place(id, M.config.sign_group, name, bufnr, { lnum = lnum })
  elseif mark:match("[a-z]") then
    -- Only unplace marks with this label in the current buffer
    vim.fn.sign_unplace(M.config.sign_group, { id = id, buffer = bufnr })
    if lnum == 0 then
      return
    end
    vim.fn.sign_place(id, M.config.sign_group, name, bufnr, { lnum = lnum })
  end
end

function M.place_all_marks(bufnr)
  local marks = vim.list_extend(vim.fn.getmarklist(), vim.fn.getmarklist(bufnr))
  for _, mark in ipairs(marks) do
    local mark_char = mark.mark:sub(2, 2)

    if mark_char:match("[A-Za-z]") and mark.pos[1] == bufnr then
      vim.fn.sign_place(
        mark_char:byte(),
        M.config.sign_group,
        M.config.name_prefix .. mark_char,
        mark.pos[1],
        { lnum = mark.pos[2] }
      )
    end
  end
end

function M.setup(user_config)
  -- Merge user config with defaults
  if user_config then
    M.config = vim.tbl_deep_extend("force", M.config, user_config)
  end

  -- Define highlight groups
  vim.api.nvim_set_hl(0, "MarkGutterLower", { link = "DiagnosticSignOk", default = true })
  vim.api.nvim_set_hl(0, "MarkGutterUpper", { link = "DiagnosticSignOk", default = true })

  -- Lowercase marks (a-z)
  for i = 97, 122 do
    local char = string.char(i)
    vim.fn.sign_define(M.config.name_prefix .. char, {
      text = char,
      texthl = "MarkGutterLower",
      linehl = "",
      numhl = "",
    })
  end

  -- Uppercase marks (A-Z)
  for i = 65, 90 do
    local char = string.char(i)
    vim.fn.sign_define(M.config.name_prefix .. char, {
      text = char,
      texthl = "MarkGutterUpper",
      linehl = "",
      numhl = "",
      priority = M.config.priority,
    })
  end

  local augroup = vim.api.nvim_create_augroup(M.config.sign_group, { clear = true })

  -- Render all marks in a given buffer. We use BufWinEnter with manual logic to
  -- only trigger once, since I can't find an event that triggers both once AND
  -- late enough for signcolumn rendering
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup,
    callback = function(ctx)
      -- The MarkSet autocmd uses sign_unplace to remove a global mark from an
      -- existing buffer when it's set somewhere else, so we only need this
      -- autocmd to trigger on first open
      if vim.bo[ctx.buf].buflisted and not vim.b.marks_placed then
        vim.b.marks_placed = true
        M.place_all_marks(ctx.buf)
      end
    end,
  })

  vim.api.nvim_create_autocmd("MarkSet", {
    group = augroup,
    callback = function(event)
      M.place_mark(event.buf, event.data.name, event.data.line)
    end,
  })

  vim.keymap.set("n", "dm", function()
    local mark = vim.fn.getcharstr()
    -- This triggers MarkSet with an lnum and col of 0, and the autocmd handles
    -- the sign deletion
    vim.api.nvim_buf_del_mark(0, mark)
  end, { desc = "Delete mark" })

  vim.keymap.set("n", "dM", function()
    vim.fn.sign_unplace(M.config.sign_group)
    vim.cmd("delmarks a-zA-Z")
  end, { desc = "Delete all marks" })
end

if vim.fn.has("nvim-0.12") == 1 then
  M.setup()
else
  vim.print("Nightly neovim required!")
end
