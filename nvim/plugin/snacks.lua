require("snacks").setup({
  quickfile = { enabled = true },

  -- Doesn't replace all input, but will work for stuff like lsp renames
  input = {
    enabled = true,
    win = {
      on_win = function()
        if vim.g.input_completion then
          vim.g.input_completion = false
          vim.b.completion = true
        end
        if vim.g.input_normal_mode then
          vim.g.input_normal_mode = false
          -- See https://github.com/folke/snacks.nvim/issues/2198
          vim.schedule(function()
            vim.cmd("stopinsert")
            vim.cmd("normal! ^")
          end)
        end
      end,
    },
  },

  -- Display indent lines, like `indent-blankline`
  indent = {
    enabled = true,

    -- We use `mini.indentscope` for displaying the current scope, since it's
    -- more customizable and doesn't trigger on empty whitespace
    scope = { enabled = false },
  },
})
