local canola = require("canola")
local fzf_lua = require("fzf-lua")
local ns = vim.api.nvim_create_namespace("CanolaHighlights")

vim.b.search_char = nil
local sort_by_recent = false

local function search_first_char(reuse_prompt, forward)
  local buf = 0

  local prompt
  if reuse_prompt then
    prompt = vim.b.search_char
    if prompt == nil then
      vim.print("Can't repeat search without searching!")
      return
    end
  else
    prompt = vim.fn.getcharstr()
  end

  -- Search for the prompt character, limiting the search range to the first
  -- column of every line.
  local search_col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local pattern = "\\%" .. search_col .. "c" .. prompt
  local flags = forward and "" or "b"
  vim.fn.search(pattern, flags)

  -- Exit early in `<C-;> mode`, so we don't regenerate highlights for no reason
  if reuse_prompt then
    return
  end

  vim.b.search_char = prompt
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  -- Iterate through all the matched lines and highlight them
  -- Note that we need to get the current buf - bufnr of 0 doesn't work for matchbufline!
  local matches = vim.fn.matchbufline(vim.api.nvim_get_current_buf(), pattern, 1, "$")
  for _, match in ipairs(matches) do
    local line = unpack(vim.api.nvim_buf_get_lines(buf, match.lnum - 1, match.lnum, true))
    local col = string.sub(line, search_col, search_col)

    if col == prompt then
      vim.api.nvim_buf_set_extmark(buf, ns, match.lnum - 1, search_col - 1, {
        hl_group = { "DiagnosticWarn" },
        end_col = line:len(),
        id = match.lnum,
      })
    end
  end
end

vim.g.canola = {
  confirm = false, -- Don't require confirm
  cursor = true, -- Keep cursor constrained
  save = "auto", -- Autosave nonexistent files
  float = {
    padding = 3,
    title = false, -- Don't show the title in a floating window
  },
  delete = {
    wipe = true, -- Autodelete open buffers when file deleted
  },

  keymaps = {
    ["<C-h>"] = "actions.parent",
    ["<C-l>"] = "actions.select",

    -- Print path to current entry
    ["g~"] = function()
      local dir = canola.get_current_dir()
      local entry = canola.get_cursor_entry()
      if entry == nil then
        return
      end
      vim.print(dir .. entry.name)
    end,

    ["<C-f>"] = {
      callback = function()
        search_first_char(false, true)
      end,
      mode = "n",
    },
    ["<C-;>"] = {
      callback = function()
        search_first_char(true, true)
      end,
      mode = "n",
    },
    ["<C-,>"] = {
      callback = function()
        search_first_char(true, false)
      end,
      mode = "n",
    },

    ["<CR>"] = false,
    ["<C-p>"] = false,
    q = false,

    ["<Esc>"] = {
      callback = "actions.close",
      mode = "n",
    },
    ["<Tab>"] = "actions.preview",

    gs = {
      callback = function()
        sort_by_recent = not sort_by_recent
        if sort_by_recent then
          canola.set_sort({ { "mtime", "desc" } })
          canola.set_columns({
            { "mtime", highlight = "NonText", format = "%m/%d" },
            { "icon" },
          })
        else
          canola.set_sort({
            { "type", "asc" },
            { "name", "asc" },
          })
          canola.set_columns({ "icon" })
        end
      end,
      nowait = true, -- Override the existing `gs` bind
    },

    ["<C-a>"] = "actions.add_to_qflist",
    ["<leader>f"] = "<Nop>",

    -- Heavily referenced from
    -- https://github.com/samiulsami/nvim/blob/7a72a0c7328ba4dc58bfe4e0d32750a5323f6267/lua/plugins/oil.lua#L94
    ["<leader>s"] = function()
      fzf_lua.live_grep({
        cwd = canola.get_current_dir(),
        cwd_prompt = true,
        actions = {
          ["default"] = function(selected, opts)
            canola.close()
            fzf_lua.actions.file_edit_or_qf(selected, opts)
          end,
        },
      })
    end,
  },
}

-- Delete files to the system trash
vim.g.canola_trash = {}

vim.keymap.set("n", "<leader>e", canola.open_float)
vim.keymap.set("n", "<leader>E", function()
  canola.open_float(".")
end)
