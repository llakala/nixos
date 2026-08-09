require("fFtT-highlights"):setup({
  -- Require semicolon and comma to move between instances, rather than
  -- repeating `f` to move again
  smart_motions = false,

  reset_key = "<Esc>",

  match_highlight = {
    -- If I go past a match, still show it, as long as it's in the closest 5.
    -- Means if I accidentally skip the match I wanted, it stays highlighted!
    persist_matches = 5,
  },

  backdrop = {
    style = {
      -- Gray out the text when selecting the first match, but don't gray it out
      -- when moving between matches
      on_key_press = "full",
      show_in_motion = "none",
    },
  },

  jumpable_chars = {
    show_instantly_jumpable = "on_key_press",
    show_all_jumpable_in_words = "on_key_press",
  },

  -- There are two types of resets: `f<Esc>`, where we clear the gray text, and
  -- `fi<Esc>`, where we clear the orange highlights. This only adds
  -- `nohlsearch` and `echo` to the FIRST kind.
  on_reset = function()
    vim.cmd.nohlsearch()
    vim.cmd('echo ""')
  end,
})

-- This is the SECOND kind of reset: `fi<Esc>`. You'll notice that this doesn't
-- actually use any mechanisms from the plugin. However, it still clears the
-- orange highlights!
vim.keymap.set("n", "<Esc>", function()
  vim.cmd.nohlsearch()
  vim.cmd('echo ""')
end, { silent = true, desc = "Clear highlights and cmdline" })
