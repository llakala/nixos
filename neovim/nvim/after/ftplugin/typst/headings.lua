local regex = "^=\\+"

-- Jump between headers in Typst. There isn't much precedence for what to do
-- with the beginning/end of the buffer when there aren't any matches - so I
-- copied the behavior of python, where `]]` will take you to the beginning of
-- the last line if there aren't any matches, and `[[` will only take you to the
-- beginning of the first line if you're already there. Quite strange behavior,
-- but I'll obey.
vim.keymap.set({ "n", "o", "x" }, "]]", function()
  for _ = 1, vim.v.count1 do
    if vim.fn.search(regex, "W") == 0 then
      vim.cmd("normal! G^")
    end
  end
end, { buffer = true })

vim.keymap.set({ "n", "o", "x" }, "[[", function()
  for _ = 1, vim.v.count1 do
    if vim.api.nvim_win_get_cursor(0)[1] == 1 then
      vim.cmd("normal! ^")
    end
    vim.fn.search(regex, "Wb")
  end
end, { buffer = true })
