require("mini.ai").setup({
  custom_textobjects = {
    -- mini.ai makes this an alias for any type of bracket, which I'll
    -- realistically never use - I like using a specific bracket type
    b = false,

    -- From https://github.com/juselara1/nvim/blob/74551d65446aef071df202aa679a4419e4e8b522/lua/juselara/plugins/miniai.lua#L16C12-L16C32
    -- We add this for all languages, since I still use codeblocks in languages
    -- where they aren't a feature (like git commit descriptions)
    ["C"] = { "```%S*%s()[^`]+()```" },
  },
})
