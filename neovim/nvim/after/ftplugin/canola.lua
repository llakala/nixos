local group = vim.api.nvim_create_augroup("OpenQuickfixAutomatically", {})

vim.api.nvim_create_autocmd("QuickFixCmdPre", {
  buffer = 0,
  group = group,
  callback = function()
    vim.api.nvim_create_autocmd("WinClosed", {
      once = true,
      group = group,
      command = "copen",
    })
  end,
})
