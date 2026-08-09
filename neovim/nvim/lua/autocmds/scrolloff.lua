local group = vim.api.nvim_create_augroup("CenterCurrentLine", {})
-- Better `:set scrolloff` for keeping the cursor centered. `zz` has the
-- frustrating behavior of always clearing highlights, even if the current line
-- is already centered. This breaks my `fFtT` character highlighting. To fix
-- this, we only run `zz` if we actually changed lines.
--
-- Credit to
-- https://github.com/fsmiamoto/dotfiles/blob/21a9d9fc31be43f6d6daae796be543f841fe840f/common/.vimrc#L292
-- for the impl
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  desc = "Center cursor",
  group = group,
  callback = function()
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]

    -- Whenever we open a buffer, we'll always start at line 1 - even if we open
    -- at a specific line, nvim still starts at line 1, it just moves you after
    -- the buffer is loaded. This means that if prev isn't set, we must be at
    -- line 1!
    local prev_line = vim.b.prev_line or 1

    if prev_line ~= curr_line then
      vim.cmd("normal! zz")
      vim.b.prev_line = curr_line
    end
  end,
})

-- with buffer centering, M is annoying and scrolls up at the end of a buffer. I
-- prefer it to consistently go to the "screen middle" of the current window,
-- and be equivalent to ggL
vim.keymap.set({ "n", "x" }, "M", function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local visual_middle = vim.fn.line("w0") + vim.o.scroll

  if current_line ~= visual_middle then
    return visual_middle .. "G"
  end
end, { expr = true })

vim.api.nvim_create_user_command("NoScrolloff", function()
  vim.api.nvim_del_augroup_by_id(group)
  vim.keymap.del({ "n", "x" }, "M")
end, {})
