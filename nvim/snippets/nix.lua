local function not_in_comment()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local node = vim.treesitter.get_node({
    pos = { row - 1, col - 1 },
  })
  return node and node:type() ~= "comment"
end

return {
  s({
    trig = "let",
    show_condition = not_in_comment,
  }, fmt("let\n  {}\nin ", { i(1) }), {}),

  s({
    trig = "inherit",
    show_condition = not_in_comment,
  }, fmt("inherit ({}) {};", { i(1), i(2) })),
}
