--[[
Yes, I know - a lot of text! I like overcommenting my regex.

This command merges any instances of newline brackets onto the previous line -
primarily designed for Nix. These are separated into two different substitute
expressions. Before we start going through each, a few notes that apply to both:

`\v` lets us work in extra-magic mode, so parentheses are automatically
interpreted as the start of a capturing group. It means we need to escape more
literal characters like `{`, but it's a worthy exchange.

`\=` gives us a literal equals sign, because we're in \v. We use \= again
later, and it's treated very differently - don't get confused!

We use & as our separator! See `:h pattern-delimiter`
--]]
vim.api.nvim_create_user_command("Deallman", function()
  --[[
  Turns something like this:

  foo =
  {

  }

  into this:

  foo = {

  }

  The first real bit of logic comes with `\=\n\s*` This matches an equals sign,
  followed by a newline, followed by any amount of whitespace on the next line.
  Easy! The equals sign being immediately followed by the newline means that we
  now know this is a case of Allman brackets that should be fixed.

  The next bit of logic is: `([\[\{\(])`. This is a capturing group, containing
  a character class that matches for a `[`, `{`, or `(`. This is the end of our
  match, and we now move onto the replacement!

  `= \1` is super simple: it gives us an equals sign, a space, and our capturing
  group, containing the bracket that was previously on the next line. With that,
  we're done!
  --]]
  vim.cmd([[:%s:\v\=\n\s*([\[\{\(]):= \1:ge]])

  --[[
  This is a more complicated regex expression than the previous one. It turns something like this:

  foo = attrsToList
  {

  }

  Into something like this:

  foo = attrsToList {

  }

  After boilerplate, we get into a hefty bit of logic: `\=([^\:\n]+)`. The
  beginning is just an equals sign - but then we get into the real nonsense.
  Without going into every syntax element, what we have is a capturing group for
  1+ characters, where each character can be anything EXCEPT a colon or newline.
  This lets us match for any functions that are being called on the following
  attrset/list/whatever - even multiple of them! You might ask why we don't
  handle colons - this is because function DEFINITIONS are a lot more
  opinionated to format, and I don't consider it within scope.

  Next up is `\n\s*([\[\{\(])`, This logic is identical to the first function:
  a newline, infinite whitespace, then any bracket.

  Now, we finish the search, and move onto the replacement: `\1 \2`. This is
  very simple: first capturing group, a space, then the second capturing group.
  The first capturing group contains the function(s) being called, while the
  second capturing group is the bracket previously found on the next line.
  --]]
  vim.cmd([[:%s&\v\=([^\:\n]+)\n\s*([\[\{\(])&=\1 \2]])
end, {})
