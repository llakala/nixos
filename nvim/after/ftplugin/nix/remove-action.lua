-- Remove the nil_ls "quote as" code action for attrs, since I find it useless
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set({ "n", "x" }, "ga", function()
      return vim.lsp.buf.code_action({
        filter = function(action)
          return action.title:find("^Quote as") == nil
        end,
      })
    end, { buf = 0 })
  end,
})
