local MiniAi = require("mini.ai")
vim.b.miniai_config = {
  custom_textobjects = {
    ["$"] = MiniAi.gen_spec.pair("$", "$", { type = "balanced" }),
  },
}
