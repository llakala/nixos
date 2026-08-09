vim.env.FZF_DEFAULT_OPTS = nil
local utils = require("fzf-lua.utils")

require("fzf-lua").setup({
  ui_select = {},
  previewers = {
    builtin = {
      -- This breaks tex files, due to an error with `standalone.cls`! I hate
      -- snacks more and more, folke loves abandonware
      snacks_image = { enabled = false },
    },
  },

  -- Set up basic vim bindings.
  keymap = {
    fzf = {
      true, -- Inherit from default fzf keybinds
      jump = "accept",

      -- Normal (ish) mode keybinds.
      ["ctrl-j"] = "down",
      ["ctrl-k"] = "up",
      ["ctrl-l"] = "accept",
      ["ctrl-f"] = "jump",
    },
    builtin = {
      true,
      ["<A-j>"] = "preview-down",
      ["<A-k>"] = "preview-up",
      ["<C-Space>"] = "toggle-preview",
    },
  },

  -- Autoselect current document symbol in `:FzfLua lsp_document_symbols` (bound
  -- to gO by default)
  lsp = {
    symbols = {
      locate = true,
    },
  },

  buffers = {
    -- We want to show helpfiles, but they're unlisted - so we allow all
    -- unlisted buffers, but filter them for only helpfiles
    show_unlisted = true,
    filter = function(bufnr)
      local bo = vim.bo[bufnr]
      return bo.filetype == "help" or bo.buflisted
    end,
  },

  files = {
    -- Changed from the default to also remove .direnv
    fd_opts = "--color=never --hidden --type f --type l --exclude .git --exclude .direnv",
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files",
    },
  },

  -- Add fixed-strings to the default, and make ctrl-r toggle regex search on/off
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --fixed-strings -e",
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-search",
    },
    actions = {
      ["ctrl-g"] = false,
      ["ctrl-r"] = {
        fn = function(_, opts)
          FzfLua.actions.toggle_flag(
            _,
            vim.tbl_extend("force", opts, {
              toggle_flag = "--fixed-strings",
            })
          )
        end,
        header = function(o)
          local flag = "--fixed-strings"
          local cmd = o.cmd or o._cmd
          if cmd and cmd:match(utils.lua_regex_escape(flag)) then
            return "enable regex"
          else
            return "disable regex"
          end
        end,
      },
    },
  },

  -- Automatically create an fzf colorscheme based on our nvim colorscheme
  fzf_colors = true,

  winopts = {
    row = 0.50,
    preview = {
      layout = "vertical",
      vertical = "up:45%",
    },
  },

  fzf_opts = {
    ["--cycle"] = true,
  },
})

vim.keymap.set("n", "<leader>b", FzfLua.buffers, { desc = "Swap buffer, including hidden buffers" })

vim.keymap.set("n", "<leader>f", FzfLua.files, { desc = "Add new file in project" })
vim.keymap.set("n", "<leader>F", function()
  FzfLua.files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Add new file in current folder" })

vim.keymap.set("n", "<leader>s", FzfLua.live_grep, { desc = "Search text in project" })
vim.keymap.set("n", "<leader>S", function()
  FzfLua.live_grep_native({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Search text in current folder" })

vim.keymap.set("n", "<leader>h", require("custom.hifiki").hire, {})
vim.keymap.set("n", "<leader>u", require("custom.hifiki").fire, {})
vim.keymap.set("n", "<leader>k", require("custom.hifiki").kill, {})
