-- When unsuspending, check if the file has been modified outside of nvim. If
-- so, give us a notification to choose what to do. Not a very pretty
-- notification - I really need a plugin for this. But better than nothing!
vim.api.nvim_create_autocmd("VimResume", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("CheckOnSuspend", {}),
  command = "checktime",
})

-- If this is on, it'll auto-reload the file if we didn't change it. We don't
-- want that - we can do it ourselves. We just want to know.
vim.o.autoread = false
