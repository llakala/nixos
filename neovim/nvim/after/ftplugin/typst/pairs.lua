local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- Groups that are allowed/disallowed for triggering a pair
local math = {
  { "content", "code" },
  { "string" },
}
local content = {
  { "content" },
  { "math", "string", "code" },
}

-- We want to only allow moving past a delimiter if it's the second one. This
-- should be trivial, but the typst treesitter grammar has really stupid
-- behavior with the current node. If you're right before some block, it counts
-- as being inside it! See my issue report about this:
-- https://github.com/uben0/tree-sitter-typst/issues/53

-- However, we can actually abuse this to fix our problem. If we're inside a set
-- of $$, the current node will be an anonymous $ (the second one). We only
-- allow moving forward if we have a previous sibling, which we will - either
-- the first $, or some formula) However, if we were BEFORE the $$, we'd be
-- looking at the first $, but there would be no previous sibling.
local function can_move_past(char)
  return function()
    local node = vim.treesitter.get_node({ include_anonymous = true })
    return node and node:type() == char and node:prev_sibling() ~= nil
  end
end

require("nvim-autopairs").add_rules({
  -- Allow delimiters before a dollar sign within math
  Rule("(", ")", { "typst" }):with_pair(cond.after_text("$")),
  Rule('"', '"', { "typst" }):with_pair(cond.after_text("$")),

  Rule("$", "$", "typst")
    :with_pair(function()
      return Custom.in_ts_group(math[1], math[2], true)
    end)
    -- only allow moving past the right $, not the left one
    :with_move(can_move_past("$")),

  Autopairs_utils.surrounding_spaces("$", " ", "$", "typst"),

  Rule("*", "*", "typst")
    :with_pair(function()
      return Custom.in_ts_group(content[1], content[2], true)
    end)
    -- only allow moving past the right *, not the left one
    :with_move(can_move_past("*")),

  Rule("_", "_", "typst")
    :with_pair(function()
      return Custom.in_ts_group(content[1], content[2], true)
    end)
    -- only allow moving past the right _, not the left one
    :with_move(can_move_past("_")),

  Rule("<", ">", "typst")
    :with_pair(function()
      return Custom.in_ts_group(content[1], content[2], true)
    end)
    -- No need for can_move_past, since < and > are distinguishable
    :with_move(function()
      local node = vim.treesitter.get_node({ include_anonymous = true })
      return node and node:type() == ">"
    end),
})
