require("tiny-inline-diagnostic").setup({
  options = {
    -- Will show other diagnostics, even when they're not on the current line
    -- Way better than the neovim 0.11 implementation, since you can't see the
    -- diagnostic when not on the same line. This is a tiny bit janky since it
    -- shows ^@ where there would be newlines in a message, but it's far better
    -- than the status quo!
    multilines = {
      enabled = true,
      -- Without this, a line with multiple errors seems to only show one of the
      -- errors
      always_show = true,
    },

    show_code = false,

    -- If the diagnostic is on another line, only show the first line of its
    -- message
    format = function(diag)
      local current_line = vim.api.nvim_win_get_cursor(0)[1]
      local diag_line = diag.lnum
      if diag_line + 1 == current_line then
        return diag.message
      end
      return diag.message:gmatch("[^\n]*")()
    end,
  },
})
