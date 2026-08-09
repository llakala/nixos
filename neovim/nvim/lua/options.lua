-- Improves startup time
-- We do it before everything so it can help us the most
vim.loader.enable()

local g = vim.g
local o = vim.o

o.backup = false
o.writebackup = false
o.undofile = true -- Persistent undo

-- According to Neovim example init, this helps performance
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.o.clipboard = "unnamedplus"
  end,
})

g.mapleader = " "
o.mouse = ""
o.splitbelow = true
o.splitright = true
o.timeout = false
o.virtualedit = "block"
vim.opt.jumpoptions:append("view")
o.hidden = false
o.confirm = true

vim.opt.matchpairs:append("<:>") -- % goes between <>

-- Project-specific marks through shada file, from:
-- https://www.reddit.com/r/neovim/comments/1gv3uqk/comment/lxzi96y/
--
-- We use a custom function from the Cwd namespace that ignores subdirs of git
-- repos, so `nvim myrepo` will give the same result as `nvim myrepo/foo/bar`
-- Only activate in git repos, to save on startuptime elsewhere
local workspace_path = vim.g.repo_root
if workspace_path ~= nil then
  local cache_dir = vim.fn.stdpath("data")
  local unique_id = vim.fs.basename(workspace_path) .. "_" .. vim.fn.sha256(workspace_path):sub(1, 8)
  local shadafile = cache_dir .. "/myshada/" .. unique_id .. ".shada"
  o.shadafile = shadafile
  o.shada = "'50,<0"
end

-- If you need it, do `zi`
o.foldenable = false
o.foldmethod = "indent"

o.expandtab = true -- spaces as tab
o.tabstop = 2 -- 2 spaces for tabs
o.shiftwidth = 0 -- Reuse value of tabstop
o.shiftround = true -- Round to the nearest indentation level when using `<` and `>`
o.breakindent = true -- Continue indented wrapped line at same level
o.autoindent = true -- keep smartindent and cindent off, and rely on filetype indentation

o.wrap = false
o.textwidth = 80

-- Changes from defaults:
-- 1. Removed `t` - only comments should be autoformatted. We add it back in the
-- ftplugins of languages like markdown
-- 2. Added `r`, so comment headers get continued, but only in insert mode.
o.formatoptions = "cjqr"

o.ignorecase = true
o.smartcase = true
o.hlsearch = true -- Highlight search matches

o.showmode = false -- Using lualine
o.showcmd = true
