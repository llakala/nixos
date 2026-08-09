local isc = require("mini.indentscope")
isc.setup({
  options = {
    -- Don't care about the cursor's position within the line
    indent_at_cursor = false,

    -- This is nice in theory, but I find that it causes issues where I'm on a
    -- border when I don't want to be.
    try_as_border = false,
  },

  draw = {
    delay = 0,
    animation = isc.gen_animation.none(),
  },

  mappings = {
    goto_top = "",
    goto_bottom = "",
  },

  symbol = "│",
})

-- Custom binding that operates on the lines starting/ending an indentation level
vim.keymap.set("o", "si", Custom.operate_on_surrounding_indent)

-- Custom goto_top and goto_bottom mappings, since I dislike how they're handled
-- by default
vim.keymap.set({ "o", "x" }, "[i", function()
  if vim.api.nvim_get_mode().mode ~= "V" then
    vim.cmd("normal! V")
  end
  MiniIndentscope.move_cursor("top", false)
end)
vim.keymap.set({ "o", "x" }, "]i", function()
  if vim.api.nvim_get_mode().mode ~= "V" then
    vim.cmd("normal! V")
  end
  MiniIndentscope.move_cursor("bottom", false)
end)
vim.keymap.set({ "o", "x" }, "[I", function()
  if vim.api.nvim_get_mode().mode ~= "V" then
    vim.cmd("normal! V")
  end
  MiniIndentscope.move_cursor("top", true)
end)
vim.keymap.set({ "o", "x" }, "]I", function()
  if vim.api.nvim_get_mode().mode ~= "V" then
    vim.cmd("normal! V")
  end
  MiniIndentscope.move_cursor("bottom", true)
end)

vim.keymap.set("n", "[i", function()
  MiniIndentscope.move_cursor("top", false)
end)
vim.keymap.set("n", "]i", function()
  MiniIndentscope.move_cursor("bottom", false)
end)
vim.keymap.set("n", "[I", function()
  MiniIndentscope.move_cursor("top", true)
end)
vim.keymap.set("n", "]I", function()
  MiniIndentscope.move_cursor("bottom", true)
end)
