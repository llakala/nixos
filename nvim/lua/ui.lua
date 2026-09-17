local o = vim.o

require("vim._core.ui2").enable({})

o.winborder = "rounded"
o.termguicolors = true
o.smoothscroll = true -- Shows a continuation `>>>` when wrapping line is cut off
o.signcolumn = "yes"
o.laststatus = 3 -- Only one statusline, for better separator between horizontal splits
o.previewheight = 20

-- Custom window title, showing project cwd and current filename. Regex takes
-- the full cwd and takes everything after the last slash.
o.title = true
o.titlestring = vim.uv.cwd():match("([^/]+)$") .. ": %t"

o.cursorline = true
o.cursorlineopt = "both" -- Highlights the line number of the cursorline

o.number = true
o.relativenumber = true
