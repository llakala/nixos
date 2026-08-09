vim.keymap.set("n", "]]", function()
  for _ = 1, vim.v.count1 do
    if vim.fn.search("^diff --git", "W") == 0 then
      vim.cmd("normal! G0")
    end
  end
end, { buffer = true })
vim.keymap.set("n", "[[", function()
  for _ = 1, vim.v.count1 do
    vim.fn.search("^diff --git", "Wb")
  end
end, { buffer = true })
