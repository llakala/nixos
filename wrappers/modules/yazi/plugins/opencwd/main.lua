--- @sync entry
return {
  -- Referenced from:
  -- https://github.com/Axlefublr/dotfiles/blob/38525a7f900709efe5d0ea3005b670203626794d/yazi/plugins/storecwd.yazi/init.lua#L5
  entry = function()
    local cwd = tostring(cx.active.current.cwd)
    local file = io.open("/tmp/yazi-cwd-suspend", "w")
    if file then
      file:write(cwd)
      file:close()
    end
    ya.manager_emit("open", {})
  end,
}
