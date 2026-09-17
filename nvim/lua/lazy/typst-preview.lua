---@module "lz.n"
---@type lz.n.PluginSpec
return {
  "typst-preview-nvim",
  ft = "typst",

  keys = {
    {
      "<leader>p",
      vim.cmd.TypstPreview,
      ft = "typst",
    },
  },
  after = function()
    -- We don't call `setup` since it does its own binary nonsense - we just need
    -- the commands to exist
    require("typst-preview.commands").create_commands()
  end,
}
