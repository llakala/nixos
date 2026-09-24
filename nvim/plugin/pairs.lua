local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local conds = require("nvim-autopairs.conds")
local custom_pairs = require("custom.autopairs")

npairs.setup()

-- For testing, just run `:e` after sourcing on a given file
npairs.add_rules({
  custom_pairs.surrounding_spaces("(", " ", ")"),
  custom_pairs.surrounding_spaces("{", " ", "}"),
  custom_pairs.surrounding_spaces("[", " ", "]"),

  -- Copied from the nvim-autopairs source:
  -- https://github.com/windwp/nvim-autopairs/blob/23320e75953ac82e559c610bec5a90d9c6dfa743/lua/nvim-autopairs/rules/basic.lua#L44C8-L45C54
  -- It has this locked to specific languages, but I write codeblocks in all
  -- sorts of languages - and if I'm typing three `, I definitely want a
  -- codeblock.
  Rule("```", "```"):with_pair(conds.not_before_char("`", 3)),
})
