vim.o.wrap = true
vim.o.textwidth = 120
vim.opt_local.formatoptions:append({ t = true }) -- Wrap all text, not just comments

require("nvim-surround").buffer_setup({
  surrounds = {
    -- see https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-3134891
    ["l"] = {
      add = function()
        local clipboard = vim.fn.getreg("+"):gsub("\n", "")
        return { "[", "](" .. clipboard .. ")" }
      end,
      find = "%b[]%b()",
      delete = "^(%[)().-(%]%b())()$",
    },
  },
})
