vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Without this, I wouldn't get any auto-indentation as I type, since there
-- isn't an existing gleam indentexpr. Gleam's indentation is enough like C,
-- though, so this is good enough!
vim.o.smartindent = true

-- Provides multiple comment strings, sorted longest-shortest for precedence
-- Note that this doesn't work unless you put it in `after/ftplugin`, not normal
-- `ftplugin`. Not sure why!
vim.o.comments = ":////,:///,://"
