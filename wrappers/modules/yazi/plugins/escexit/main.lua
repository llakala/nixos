--- @sync entry
return {
  -- exit the current mode if it exists, or quit Yazi if no mode is set
  -- Nice QOL for yazi.nvim so I can easily exit, while also being able
  -- to stop filtering/searching easily. Referenced from:
  -- https://github.com/sxyazi/yazi/pull/1042
  -- oh, and we also store the CWD on quit
  entry = function()
    local active = cx.active
    local current = active.current

    local esc = active.mode.is_visual or #active.selected > 0 or current.files.filter or current.cwd.is_search

    if esc then
      ya.manager_emit("escape", {})
    else
      local cwd = tostring(current.cwd)
      local file = io.open("/tmp/yazi-cwd-suspend", "w")

      if file then
        file:write(cwd)
        file:close()
      end
      ya.manager_emit("quit", {})
    end
  end,
}
