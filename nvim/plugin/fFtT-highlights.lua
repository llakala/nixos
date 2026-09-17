require("fFtT-highlights"):setup({
  -- Require semicolon and comma to move between instances, rather than
  -- repeating `f` to move again
  smart_motions = false,

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
})
