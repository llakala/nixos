local ls = require("luasnip")

local function in_math()
  return in_ts_group({ "math" }, { "code", "content", "string" })
end

-- We would use `extend_decorator.apply`, but it doen't allow a string trig,
-- which I would miss. Instead, we write a simple wrapper that makes it an
-- autosnippet that only triggers in math mode
local function autoparse(trig, body, opts)
  trig = {
    snippetType = "autosnippet",
    condition = in_math,
    trig = trig,
  }

  return ls.parser.parse_snippet(trig, body, opts)
end

-- Referenced from:
-- https://github.com/pxwg/LM-nvim/blob/418448fa0bea2c29e3abf4b0e7e340a79bc467a0/luasnip/typst_1/matrices.lua#L31
-- Allows going rowwise or colwise, depending on whether `v` is passed
local function generate_matrix(_, snip)
  local rows = tonumber(snip.captures[1])
  local cols = tonumber(snip.captures[2])
  local nodes = {}

  -- If we want to iterate vertically, we'll instead make placeholders like: `$1, $4, $7; $2, $5, $8; $3, $6, $9`
  -- luasnip is smart enough to understand snippet placeholders that aren't in order, so this works!
  local function get_index(col, row)
    if snip.captures[3] == "v" then
      return i(row + (col - 1) * rows)
    end
    return i(col + (row - 1) * cols)
  end

  for row = 1, rows do
    table.insert(nodes, t("  "))
    table.insert(nodes, get_index(1, row))

    for col = 2, cols do
      table.insert(nodes, t(", "))
      table.insert(nodes, get_index(col, row))
    end

    -- No extra newline on the last element
    if row < rows then
      table.insert(nodes, t({ ";", "" }))
    else
      table.insert(nodes, t({ ";" }))
    end
  end

  return sn(nil, nodes)
end

return {
  autoparse("sumt", "sum_(${1:i}=${2:0})^(${3:N})"),
  autoparse("ihat", "hat(i)"),
  autoparse("jhat", "hat(j)"),
  autoparse("khat", "hat(k)"),

  s(
    {
      trig = "(%d)(%d)(v?)mat",
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta(
      [[
        mat(
        <>
        )<>]],
      {
        d(1, generate_matrix),
        i(0),
      }
    ),
    { condition = in_math }
  ),
}
