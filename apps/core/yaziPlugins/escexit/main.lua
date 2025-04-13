--- @sync entry
return {
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
