-- Remove the nil_ls "quote as" code action for attrs, since I find it useless
vim.keymap.set({ "n", "x" }, "ga", function()
  return vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:find("^Quote as") == nil
    end,
  })
end, { buffer = true })
