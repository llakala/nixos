local mini_ai = require("mini.ai")

vim.b.miniai_config = {
  custom_textobjects = {
    ["$"] = mini_ai.gen_spec.pair("$", "$", { type = "balanced" }),
  },
}
