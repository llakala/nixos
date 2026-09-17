---@module "lz.n"
---@type lz.n.PluginSpec
return {
  "markdown-preview-nvim",
  ft = "markdown",

  keys = {
    {
      "<leader>p",
      vim.cmd.MarkdownPreview,
      ft = "markdown",
    },
  },

  after = function()
    -- Don't autostart markdown preview, However, once it is open, if we change
    -- buffers, open the markdown file in the same file.
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_combine_preview = 1

    vim.cmd([[
      function OpenMarkdownPreview(url)
        execute "silent !firefox " . a:url
      endfunction
    ]])

    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  end,
}
