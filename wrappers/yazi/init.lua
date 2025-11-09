-- Makes yazi update the zoxide database on navigation
-- From https://github.com/sxyazi/yazi/discussions/860
require("zoxide"):setup({
  update_db = true,
})

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.deleted_sign = "D"
th.git.untracked_sign = "A"
require("git"):setup()
