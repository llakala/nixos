local nvim_surround = require("nvim-surround")
local config = require("nvim-surround.config")

-- The defaults use ( for whitespace, and ) for no whitespace. Silly!
-- See https://github.com/kylechui/nvim-surround/issues/384
local function reverse_default(left, right, use_whitespace)
  local add = nil
  local delete = nil

  if use_whitespace == true then
    add = { left .. " ", " " .. right } or {}
    delete = "^(. ?)().-( ?.)()$"
  else
    add = { left, right }
    delete = "^(.)().-(.)()$"
  end

  return {
    add = add,
    find = function()
      -- search for the covering textobject - see the next function for
      -- an explanation
      return config.get_selection({ motion = "as" .. (use_whitespace and right or left) })
    end,
    delete = delete,
  }
end

-- I have mini.ai set up so `dis(` / `das(` only searches the covering
-- textobject, and never jumps forward. I find this more intuitive, since
-- "surrounding" should refer to what actually surrounds you. We replace any
-- instances in the defaults of `get_selection({ motion = })` to use a
-- surrounding motion instead
local function use_covering_tobj(char)
  return {
    find = function()
      return config.get_selection({ motion = "as" .. char })
    end,
  }
end

vim.g.nvim_surround_no_normal_mappings = true

vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)")
vim.keymap.set("n", "ss", "<Plug>(nvim-surround-normal-cur)")
vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal-line)")
vim.keymap.set("n", "gss", "<Plug>(nvim-surround-normal-cur-line)")

vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)")
vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual-line)")

vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)")
vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)")

nvim_surround.setup({
  move_cursor = "sticky",

  aliases = {
    a = false,
    b = false,
    B = false,
    r = false,
    s = false,
  },

  surrounds = {
    ["("] = reverse_default("(", ")", false),
    [")"] = reverse_default("(", ")", true),

    ["["] = reverse_default("[", "]", false),
    ["]"] = reverse_default("[", "]", true),

    ["{"] = reverse_default("{", "}", false),
    ["}"] = reverse_default("{", "}", true),

    ["<"] = reverse_default("<", ">", false),
    [">"] = reverse_default("<", ">", true),

    ["<CR>"] = {
      find = "\n(\n)().-\n(\n)()",
    },

    ["'"] = use_covering_tobj("'"),
    ['"'] = use_covering_tobj('"'),
    ["`"] = use_covering_tobj("`"),
    ["t"] = use_covering_tobj("t"),
    ["T"] = use_covering_tobj("t"),

    -- codeblock! We add this for all languages, since I still use codeblocks in
    -- languages where they aren't a feature (like git commit descriptions)
    ["C"] = {
      add = { { "", "```", "" }, { "", "```", "" } },
      find = "```.-```",

      -- From https://github.com/gen4438/dotfiles/blob/0822a4bc6d652bf3c7d03adc3020808861d448d1/dot_config/nvim/lua/plugins/vim-surround.lua#L57
      -- Slightly modified to preserve the wrapping lines
      delete = "^(```.-)()%\n.-(```)()$",
    },

    -- Works with lines surrounding the current indentation level
    i = {
      delete = function()
        return Custom.get_indent_selections(true, require("nvim-surround.cache").delete.count)
      end,
      change = {
        target = function()
          return Custom.get_indent_selections(false, require("nvim-surround.cache").change.count)
        end,
      },
    },

    -- Modified defaults to also reject alphabetical characters, since I never
    -- want to use them for surrounding
    invalid_key_behavior = {
      add = function(char)
        if not char or char:find("[%a%c]") then
          return nil
        end
        return { { char }, { char } }
      end,
      find = function(char)
        if not char or char:find("[%a%c]") then
          return nil
        end
        return require("nvim-surround.config").get_selection({
          pattern = vim.pesc(char) .. ".-" .. vim.pesc(char),
        })
      end,
    },
  },
})

-- This inherits from Visual by default, which is not very readable on my
-- colorscheme. We don't change Visual itself, because this color isn't very
-- good for comments. There's probably a way to make comments handle that
-- better, idk.
vim.api.nvim_set_hl(0, "NvimSurroundHighlight", { bg = "#465172" })
