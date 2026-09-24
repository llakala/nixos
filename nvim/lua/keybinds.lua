function cabbrev(alias, expansion)
  local should_expand

  -- If the first character is uppercase (necessary for creating a user command)
  if string.match(alias, "^%u") then
    -- create a fake user command so that nvim_parse_cmd doesn't error
    vim.api.nvim_create_user_command(alias, function() end, { range = true })
    should_expand = function()
      local ok, parsed_cmdline = pcall(vim.api.nvim_parse_cmd, vim.fn.getcmdline())
      return ok and parsed_cmdline.cmd == alias
    end
  else
    -- fallback to a weak check
    should_expand = function()
      return vim.fn.getcmdline() == alias
    end
  end

  vim.keymap.set("ca", alias, function()
    if vim.fn.getcmdtype() == ":" and should_expand() then
      return expansion
    else
      return alias
    end
  end, { expr = true })
end

-- i<Esc> won't move the cursor at all, while a<Esc> will move the cursor
-- one to the right. I prefer this, as I use i more than a. Helix-style!
vim.keymap.set("n", "i", function()
  vim.b.move_left = true
  return "i"
end, { expr = true })
vim.keymap.set("n", "a", function()
  vim.b.move_left = true
  return "a"
end, { expr = true })
vim.keymap.set("i", "<Esc>", function()
  if vim.b.move_left then
    vim.b.move_left = false
    return "<Right><Esc>"
  end
  return "<Esc>"
end, { expr = true })

-- <Esc> to clear search highlights, remove multiple cursors, etc
vim.keymap.set("n", "<Esc>", function()
  vim.lsp.buf.clear_references()
  return "<C-l>"
end, { remap = true, expr = true })

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.set("n", "<leader><leader>", "<C-^>")

local ERROR = vim.diagnostic.severity.ERROR
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = ERROR })
end, { desc = "Previous error" })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = ERROR })
end, { desc = "Next error" })

-- Use blackhole register for all editing keymaps
for _, lhs in pairs({ "c", "C", "d", "D", "s", "S", "x", "X" }) do
  vim.keymap.set({ "x", "n" }, lhs, '"_' .. lhs)
end

-- Opt in to copying to clipboard. Since timeout is disabled, this makes `dyip`
-- delete the current word and yank it
vim.keymap.set("n", "dy", "d")
vim.keymap.set("n", "dY", "D")
vim.keymap.set("x", "D", "d")

vim.keymap.set("n", "cy", "c")
vim.keymap.set("n", "cY", "C")
vim.keymap.set("x", "C", "c")

-- q to close nvim entirely, d to close the current buffer. however, wq should
-- only write the current buffer. if you really want to write all buffers, use
-- :wa
cabbrev("d", "close")
cabbrev("wd", "w | close")
cabbrev("q", "qa")
cabbrev("wq", "w | qa")

-- By default, J's count isn't relative, so 2J doesn't perform J twice. I hate
-- this, so we fix it!
vim.keymap.set("n", "J", function()
  vim.cmd("normal! " .. vim.v.count1 + 1 .. "J")
end)

-- i find vanilla gJ useless - make it remove any existing indentation
vim.keymap.set("n", "gJ", function()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local col = #vim.api.nvim_get_current_line()

  local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + vim.v.count1, false)
  -- exit early if on last line of the buffer
  if #lines == 0 then
    return
  end

  local line
  local merged_lines = ""
  for i = 1, #lines do
    -- deindent each line
    line = string.gsub(lines[i], "^%s+", "")
    col = col + #line
    merged_lines = merged_lines .. line
  end
  vim.api.nvim_buf_set_text(0, lnum - 1, -1, lnum - 1 + vim.v.count1, -1, { merged_lines })

  -- place our cursor at the start of the last line
  col = col - #line
  vim.api.nvim_win_set_cursor(0, { lnum, col })
end)
-- Make H move an extra line with an an odd-number window height, so HL is
-- deterministic
vim.keymap.set({ "n", "x" }, "H", function()
  if vim.api.nvim_win_get_height(0) % 2 == 1 then
    return "H"
  end
  local top = vim.fn.line("w0")
  if top == 1 then
    return "H"
  end
  return (top - 1) .. "G"
end, { expr = true })

-- Prevents an annoying issue where <Leader><Esc> moves the character one to the
-- right
vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>")

-- Paste from selection clipboard
vim.keymap.set({ "n", "x" }, "gp", '"*p')
vim.keymap.set({ "n", "x" }, "gP", '"*P')

vim.keymap.set("n", "[u", "<Cmd>earlier 1f<CR>")
vim.keymap.set("n", "]u", "<Cmd>later 1f<CR>")

vim.keymap.set("n", "<A-w>", "<C-w>") -- I have <C-w> to close a tab in Kitty. Should get rid of that!
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set("n", "<A-H>", "<C-w>H")
vim.keymap.set("n", "<A-J>", "<C-w>J")
vim.keymap.set("n", "<A-K>", "<C-w>K")
vim.keymap.set("n", "<A-L>", "<C-w>L")

local shift = require("custom.shift")

vim.keymap.set("n", ">", function()
  return shift.operator(">")
end, { expr = true })
vim.keymap.set("n", "<", function()
  return shift.operator("<")
end, { expr = true })

vim.keymap.set("n", ">>", function()
  return shift.operator(">") .. "_"
end, { expr = true })
vim.keymap.set("n", "<<", function()
  return shift.operator("<") .. "_"
end, { expr = true })

vim.keymap.set("n", ".", function()
  -- See https://github.com/neovim/neovim/discussions/40715
  Custom.cursor_before_operator = vim.api.nvim_win_get_cursor(0)
  return "."
end, { expr = true })

vim.keymap.set("c", "<C-l>", "<CR>")
vim.keymap.set("c", "<C-BS>", "<C-w>")

vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<Up>", "<Nop>")
vim.keymap.set("c", "<Down>", "<Nop>")
