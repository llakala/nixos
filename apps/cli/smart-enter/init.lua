return {
	entry = function()
		local h = cx.active.current.hovered
		if h.cha.is_dir then
			ya.manager_emit("enter" or "open", { hovered = true })
			else
				local hx_command = '\'\\e : o ' .. tostring(h.url) .. ' \\r\''
				local command = 'kitten @ send-text --match neighbor:' .. 'right ' .. hx_command
				os.execute(command)
		end
	end,
}
