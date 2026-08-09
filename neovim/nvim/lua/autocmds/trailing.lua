vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#e55c7a" })
local group = vim.api.nvim_create_augroup("ShowTrailingWhitespace", {})

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWinEnter" }, {
  pattern = "*",
  group = group,
  callback = function()
    -- buftype logic prevents weird windows like completions from getting
    -- trailing whitespace highlighting.
    if vim.bo.buftype == "" then
      if vim.w.matchid then
        vim.fn.matchdelete(vim.w.matchid)
      end
      vim.w.matchid = vim.fn.matchadd("TrailingWhitespace", [[\s\+$]])
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  -- Only shows trailing whitespace on OTHER lines, not the line you're
  -- currently typing on. Thanks, vimwiki!
  callback = function()
    if vim.bo.buftype == "" then
      vim.fn.matchdelete(vim.w.matchid)
      vim.w.matchid = vim.fn.matchadd("TrailingWhitespace", [[\s\+\%#\@<!$]])
    end
  end,
})

vim.api.nvim_create_user_command("NoTrailing", function()
  vim.fn.matchdelete(vim.w.matchid)
  vim.api.nvim_del_augroup_by_id(group)
end, {})
