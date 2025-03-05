local get_cwd = ya.sync(function()
  return tostring(cx.active.current.cwd)
end)

function git_search()
  local cwd = get_cwd()
  -- Both staged and unstaged changes
  local child = Command("git"):args({ "diff", "HEAD", "--name-only" }):cwd(cwd):stdout(Command.PIPED):spawn()
  local files = {}

  while true do
    local line, event = child:read_line()

    if event ~= 0 then
      break
    end

    line = line:gsub("\n", "")
    table.insert(files, line)
  end

  if #files > 0 then
    local args = "--files-with-matches -a ."

    for _, file in ipairs(files) do
      args = args .. string.format(' -g "%s"', file)
    end

    ya.manager_emit("search_do", { via = "rg", args = args })

  else
    ya.notify({ title = "Git search", content = "No changed files", timeout = 4 })
  end
end

return {
  entry = function(_, _)
    git_search()
  end,
}
