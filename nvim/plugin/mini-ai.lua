require("mini.ai").setup({
  mappings = {
    around_cover = "as",
    inside_cover = "is",
    goto_left = "",
    goto_right = "",
  },
  custom_textobjects = {
    -- mini.ai makes this an alias for any type of bracket, which I'll
    -- realistically never use - I like using a specific bracket type
    b = false,

    -- ig -> entire buffer
    g = function(type)
      if type == "a" then
        return
      end
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line("$"),
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end,

    -- From https://github.com/juselara1/nvim/blob/74551d65446aef071df202aa679a4419e4e8b522/lua/juselara/plugins/miniai.lua#L16C12-L16C32
    -- We add this for all languages, since I still use codeblocks in languages
    -- where they aren't a feature (like git commit descriptions)
    ["C"] = { "```%S*%s()[^`]+()```" },
  },
})

local function goto_tobj(dir, method)
  local char = vim.fn.getcharstr()
  MiniAi.move_cursor(dir, "a", char, { n_times = vim.v.count1, search_method = method })
end

-- "go <right> to start"
vim.keymap.set({ "o", "x" }, "gls", function()
  goto_tobj("left", "next")
end)
-- "go <right> to end"
vim.keymap.set({ "o", "x" }, "gle", function()
  goto_tobj("right", "cover_or_next")
end)
-- "go <left> to start"
vim.keymap.set({ "o", "x" }, "ghs", function()
  goto_tobj("left", "cover_or_prev")
end)
-- "go <left> to end"
vim.keymap.set({ "o", "x" }, "ghe", function()
  goto_tobj("right", "prev")
end)
