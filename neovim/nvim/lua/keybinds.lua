function cabbrev(alias, expanded)
  vim.keymap.set("ca", alias, function()
    local cmdline = vim.fn.getcmdline()
    if vim.fn.getcmdtype() == ":" and (cmdline == alias or cmdline == "'<,'>" .. alias) then
      return expanded
    else
      return alias
    end
  end, { expr = true })
end

-- i<Esc> won't move the cursor at all, while a<Esc> will move the cursor
-- one to the right. I prefer this, as I use i more than a. Helix-style!
vim.keymap.set("i", "<Esc>", "<Esc>l")

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
for _, mode in pairs({ "x", "n" }) do
  for _, lhs in pairs({ "c", "C", "d", "D", "s", "S", "x", "X" }) do
    vim.keymap.set(mode, lhs, '"_' .. lhs, { silent = true })
  end
end

-- Opt in to copying to clipboard. Since timeout is disabled, this makes `dyip`
-- delete the current word and yank it
vim.keymap.set("n", "dy", "d", { desc = "Delete and yank" })
vim.keymap.set("n", "dY", "D", { desc = "Delete and yank rest of line" })
vim.keymap.set("v", "D", "d", { desc = "Delete and yank selection" })

vim.keymap.set("n", "cy", "c", { desc = "Change and yank" })
vim.keymap.set("n", "cY", "C", { desc = "Change and yank rest of line" })
vim.keymap.set("v", "C", "c", { desc = "Change and yank selection" })

-- q to close nvim entirely, d to close the current buffer. however, wq should
-- only write the current buffer. if you really want to write all buffers, use
-- :wa
cabbrev("d", "close")
cabbrev("wd", "w | close")
cabbrev("q", "qa")
cabbrev("wq", "w | qa")
cabbrev("qa", 'echoerr "just use :q"')
cabbrev("wqa", 'echoerr "just use :wq"')

-- By default, J's count isn't relative, so 2J doesn't perform J twice. I hate
-- this, so we fix it!
vim.keymap.set("n", "J", function()
  vim.cmd("normal! " .. vim.v.count + 1 .. "J")
end)
vim.keymap.set("n", "gJ", function()
  vim.cmd("normal! " .. vim.v.count + 1 .. "gJ")
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
vim.keymap.set("n", "gp", '"*p')
vim.keymap.set("n", "gP", '"*P')

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
  if vim.go.operatorfunc == "v:lua.require'custom.shift'.operator_callback" then
    shift.cache.pos = vim.api.nvim_win_get_cursor(0)
  end
  return "."
end, { expr = true })
