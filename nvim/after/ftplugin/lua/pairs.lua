local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")
local conds = require("nvim-autopairs.conds")

local function add_trailing_comma(left, right)
  return Rule(left, right .. ",", "lua")
    :with_pair(conds.not_after_text(","))
    :with_pair(ts_conds.is_ts_node({ "table_constructor" }))
end

npairs.add_rules({
  Rule("=", ",", "lua")
    :with_pair(conds.not_after_regex("%s?}", 2), nil)
    :with_pair(ts_conds.is_ts_node({ "table_constructor" }))
    :with_cr(conds.none())
    :with_move(function(opts)
      return opts.char == opts.next_char:sub(1, 1)
    end),

  add_trailing_comma("(", ")"),
  add_trailing_comma('"', '"'),
  add_trailing_comma("{", "}"),
})
