local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local conds = require("nvim-autopairs.conds")

npairs.setup()

Autopairs_utils = {}

-- From wiki: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#insertion-with-surrounding-check
Autopairs_utils.surrounding_spaces = function(a1, ins, a2, lang)
  return Rule(ins, ins, lang)
    :with_pair(function(opts)
      return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
    end)
    :with_move(conds.none())
    :with_cr(conds.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
    end)
end

-- For testing, just run `:e` after sourcing on a given file
npairs.add_rules({
  Autopairs_utils.surrounding_spaces("(", " ", ")", "-lua"),
  Autopairs_utils.surrounding_spaces("{", " ", "}", "-lua"),
  Autopairs_utils.surrounding_spaces("[", " ", "]", "-lua"),

  -- Copied from the nvim-autopairs source:
  -- https://github.com/windwp/nvim-autopairs/blob/23320e75953ac82e559c610bec5a90d9c6dfa743/lua/nvim-autopairs/rules/basic.lua#L44C8-L45C54
  -- It has this locked to specific languages, but I write codeblocks in all
  -- sorts of languages - and if I'm typing three `, I definitely want a
  -- codeblock.
  Rule("```", "```"):with_pair(conds.not_before_char("`", 3)),
})
