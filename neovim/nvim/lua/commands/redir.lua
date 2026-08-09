-- Referenced from: https://www.reddit.com/r/neovim/comments/zhweuc/comment/izo9br1
vim.api.nvim_create_user_command("Redir", function(ctx)
  local exec = vim.api.nvim_exec2(":" .. ctx.args, {})
  local lines = vim.split(exec.output or "", "\n", { plain = true })

  vim.cmd("tabnew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })
