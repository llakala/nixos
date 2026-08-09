-- The defaults use ( for whitespace, and ) for no whitespace. Silly!
-- See https://github.com/kylechui/nvim-surround/issues/384
function create_surround(left, right, use_whitespace)
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
    delete = delete,
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

require("nvim-surround").setup({
  move_cursor = "sticky",

  aliases = {
    a = false,
    b = false,
    B = false,
    r = false,
    s = false,
  },

  surrounds = {
    ["("] = create_surround("(", ")", false),
    [")"] = create_surround("(", ")", true),

    ["["] = create_surround("[", "]", false),
    ["]"] = create_surround("[", "]", true),

    ["{"] = create_surround("{", "}", false),
    ["}"] = create_surround("{", "}", true),

    ["<"] = create_surround("<", ">", false),
    [">"] = create_surround("<", ">", true),

    ["<CR>"] = {
      find = "\n(\n)().-\n(\n)()",
    },

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
