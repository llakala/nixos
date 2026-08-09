-- Make brackets "Allman" style, where the opening bracket is on the next line
vim.api.nvim_create_user_command("Allman", function()
  --[[
  `\(\S\)\s*` matches non-whitespace followed by 1 or more whitespace.
  Lets us make sure we're matching for lines where the bracket isn't
  already on the next line. Allowing no whites
  `\([\[{(]\)$` matches `[`, `(`, and `{` at the end of the line.
  Now we get into the replacement. `\=` makes it treat this as
  an expression, so we can use fancy functions.
  `submatch(1)` brings back the matched text BEFORE the whitespace
  and the curly bracket. This is best shown with an example. Given
  the input `foo = {`, submatch(1) grabs the `=`. It does NOT match
  the whitespace. We have to do this because the nature of a
  replacement is that everything we grabbed gets removed - so we
  bring back that non-whitespace, but leave the whitespace, as it
  would become trailing if let into the capturing group.
  I didn't know this - `.` is a concat operator here. Cool! We place a
  newline, and go on.
  `matchstr(getline(".)` grabs the line. Not the current one that
  we've just gotten on to - the one which previously held the bracket.
  Why? I don't know!
  `,"^\s*"` is simple - it just repeats the whitespace of the previous
  line. This makes sure we're tabbed over the right amount. I'm sure
  there's a smart way to do this, but I'm happy with it for now
  Another concat, then we grab submatch(2), which is our bracket -
  whether it was {, (, or [.
  Finally, we end with options - `g`, to replace globally, and `e`,
  to not cause an error if we don't match anything.
  --]]
  vim.cmd([[:%s/\(\S\)\s\+\([\[{(]\)$/\=submatch(1) . "\r" . matchstr(getline("."),'^\s*') . submatch(2)/ge]])
end, {})
