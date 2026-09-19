local keys = vim.keycode("<CR>")

-- I have vsplit enabled in my 'switchbuf', which is generally nice, but a
-- little annoying for quickfix entries -- since every time you open a
-- non-displayed buffer, it makes a new window.
--
-- With this keymap, the *first* non-displayed buffer works as normal and
-- creates a new window -- but after that, every non-displayed buffer has to
-- "share" that window, and they aren't allowed to create a new one or write to
-- other buffers.
--
-- Of course, if the buffer is displayed on screen, none of this applies, and it
-- just jumps to the relevant buffer.
vim.keymap.set("n", "<CR>", function()
  if vim.g.preview_qf_win ~= nil and vim.api.nvim_win_is_valid(vim.g.preview_qf_win) then
    local prev = vim.o.switchbuf
    vim.opt.switchbuf = "useopen"
    vim.api.nvim_feedkeys(keys, "nx", false)
    vim.opt.switchbuf = prev
  else
    vim.api.nvim_feedkeys(keys, "nx", false)
    vim.g.preview_qf_win = vim.api.nvim_get_current_win()
  end
end, { buf = 0 })
