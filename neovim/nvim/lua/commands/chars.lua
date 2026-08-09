-- Print the frequencies of each character in a word in alphabetical order
vim.api.nvim_create_user_command("Chars", function(ctx)
  local word
  if #ctx.fargs == 0 then
    word = vim.fn.expand("<cword>")
  else
    word = ctx.fargs[1]
  end

  local frequencies = {}
  local unique_chars = {}
  for i = 1, #word do
    local char = string.sub(word, i, i)
    if frequencies[char] then
      frequencies[char] = frequencies[char] + 1
    else
      frequencies[char] = 1
      unique_chars[#unique_chars + 1] = char
    end
  end

  table.sort(unique_chars)

  local message = ""
  for _, char in ipairs(unique_chars) do
    message = message .. frequencies[char] .. char .. " "
  end

  vim.print(message)
end, { nargs = "?" })
