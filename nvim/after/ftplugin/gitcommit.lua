-- `vim-rhubarb` gives me `:Gbrowse` to open a file in Github, which is
-- wonderful. But it also comes with some completion options that don't seem to
-- work with `blink-cmp`. So, for now, disable completion in these buffers. If I
-- ever try to add a blink plugin that gives me git completions and forget about
-- this, I'll probably be very confused. Sorry, future me!
vim.b.completion = false

-- For my personal autocmd
vim.b.disable_trailing = true

-- Wrap all text, not just comments
vim.opt_local.formatoptions:append({ t = true })

-- If we're amending the current commit, show that commit's diff properly
local command
local first_line = table.concat(vim.api.nvim_buf_get_lines(0, 0, 1, false), "\n")
if first_line == "" then
  command = "DiffGitCached -p"
else
  command = "DiffGitCached -p HEAD~1"
end

vim.cmd(command)
vim.cmd("wincmd p")
