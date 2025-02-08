-- Create a map with noremap set to false
local function mkRemap(mode, key, map)
  vim.keymap.set(mode, key, map)
end

-- Create a map with noremap set to false
local function mkNoremap(mode, key, map)
  vim.keymap.set(mode, key, map, { noremap = true })
end


function map (key, map)
  mkRemap("", key, map)
end

function noremap (key, map)
  mkNoremap("", key, map)
end


function nmap(key, map)
  mkRemap("n", key, map)
end

function vmap(key, map)
  mkRemap("v", key, map)
end


function nnoremap(key, map)
  mkNoremap("n", key, map)
end

function vnoremap(key, map)
  mkNoremap("v", key, map)
end


-- System clipboard always
noremap("y", "\"+y")
noremap("p", "\"+P") -- Paste before
noremap("P", "\"+p") -- Paste after

-- Have j and k navigate visual lines rather than logical ones
nmap("j", "gj")
nmap("k", "gk")
vmap("j", "gj")
vmap("k", "gk")

-- Move around without selecting at all
nnoremap("<A-e>", "e")
nnoremap("<A-b>", "b")
vnoremap("<A-e>", "<Esc>e")
vnoremap("<A-b>", "<Esc>b")

-- Move around, selecting one word at a time
nnoremap("e", "eviw")
nnoremap("b", "bviwo")
vnoremap("e", "<Esc>eviw")
vnoremap("b", "<Esc>bviwo")

-- Move around, continuing selection
nnoremap("E", "ve")
nnoremap("B", "vb")
vnoremap("E", "e")
vnoremap("B", "b")

vnoremap("i", "<Esc>`<i")
vnoremap("a", "<Esc>`>a")

noremap("d", "\"_x") -- Delete current character, and don't copy to clipboard
noremap("c", "\"_s") -- Change, and don't copy to clipboard

noremap("U", "<C-r>") -- Redo

-- Go to beginning/end of visual line
noremap("H", "g^")
noremap("L", "g$")

noremap("<", "<<")
noremap(">", ">>")

noremap("%", "ggVG") -- Select entire file
noremap("gG","G") -- gG to go to end of file

local o = vim.opt
local g = vim.g -- Global variables

o.clipboard = "unnamed"
o.undofile = true -- Persistent undo

o.cursorline = true
o.hlsearch = true -- Highlight search matches
o.number = true
o.smartcase = true

o.autoindent = true
o.expandtab = true -- spaces as tab
o.tabstop = 2 -- 2 spaces for tabs
o.shiftwidth = 2 -- 2 spaces for tabs

g.mapleader = " "
