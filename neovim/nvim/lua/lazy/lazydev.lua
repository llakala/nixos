return {
  "lazydev-nvim",
  ft = "lua",
  after = function()
    require("lazydev").setup()
  end,
}
