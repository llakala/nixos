local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local function auto_semicolon(prefix)
  return Rule(prefix, ";", "nix")
    -- Don't add another semicolon if there already is one after the cursor
    :with_pair(cond.not_after_regex(";", 2))
    -- If we're backspacing, we don't want to get rid of the whole thing
    :with_del(function(_)
      return false
    end)
    :with_pair(cond.is_end_line())
end

npairs.add_rules({
  auto_semicolon("= "):with_pair(cond.not_before_regex("!", 2)),
  auto_semicolon("inherit "),

  Rule("/*", "*/", "nix"),
  Autopairs_utils.surrounding_spaces("/*", " ", "*/", "nix"),
})
