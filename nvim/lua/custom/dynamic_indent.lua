-- Logic from github.com/wurli/contextindent.nvim/
-- Makes shiftwidth dynamic in languages like markdown with injections
local M = {}

M.setup = function(opts)
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = opts.pattern,
    group = vim.api.nvim_create_augroup("DynamicIndent", {}),
    callback = function()
      local template = 'v:lua.require("custom/dynamic_indent").context_indent("%s")'
      vim.bo.indentexpr = template:format(vim.bo.indentexpr)
    end,
  })
end

local function safe_eval(x)
  local fn_name = x:gsub("%(%)$", "")
  if fn_name == "" then
    return
  end
  local ok, res = pcall(function()
    return vim.fn[fn_name]()
  end)
  return ok and res or nil
end

M.context_indent = function(buf_indentexpr)
  local parser_exists, parser = pcall(vim.treesitter.get_parser)

  if not parser_exists then
    -- -1 means 'fall back to autoindent'; see :help indentexpr
    return safe_eval(buf_indentexpr) or -1
  end

  local curr_ft = parser:language_for_range({ vim.v.lnum, 0, vim.v.lnum, 1 }):lang()

  if curr_ft == "" then
    return safe_eval(buf_indentexpr) or -1
  end

  local curr_indentexpr = vim.filetype.get_option(curr_ft, "indentexpr")
  vim.bo.shiftwidth = vim.filetype.get_option(curr_ft, "shiftwidth")

  if curr_indentexpr ~= "" and type(curr_indentexpr) == "string" then
    return safe_eval(curr_indentexpr)
  else
    return -1
  end
end

return M
