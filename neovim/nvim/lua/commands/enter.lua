-- Edit relative to current file
vim.api.nvim_create_user_command("Enter", function(ctx)
  if #ctx.fargs == 0 then
    vim.cmd.edit("%:p:h/<cfile>")
  end
  vim.cmd.edit("%:p:h/" .. ctx.fargs[1])
end, {
  nargs = "?",
  complete = function(arg_lead)
    -- Set 'path' to the location of the current file, thereby reusing the
    -- file_in_path logic. Setting arg_lead also allows us to use `../`
    local old = vim.bo.path
    vim.bo.path = "./" .. arg_lead
    local ret = vim.fn.getcompletion("", "file_in_path", false)
    vim.bo.path = old
    return ret
  end,
})
