local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local function auto_semicolon(prefix)
  return Rule(prefix, ";", "nix")
    -- rewrite of cond.is_end_line, since I have an off by one issue with it
    :with_pair(function(opts)
      local end_text = opts.line:sub(opts.col)
      -- end text is blank
      if end_text ~= "" and end_text:match("^%s+$") == nil then
        return false
      end
    end)
    -- If we're backspacing, we don't want to get rid of the whole thing
    :with_del(function()
      return false
    end)
end

npairs.add_rules({
  auto_semicolon("= ")
    -- not_before_regex only ignores the current character, so go two
    -- characters back from it
    :with_pair(
      cond.not_before_regex("!=", 2)
    )
    :with_pair(cond.not_before_regex("==", 2)),
  auto_semicolon("inherit "),

  Rule("/*", "*/", "nix"),
  Autopairs_utils.surrounding_spaces("/*", " ", "*/", "nix"),
})
