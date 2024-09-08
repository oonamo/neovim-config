local M = {}
M.flavours = {}

function M.get_colors()
	if M.colors then
		return M.colors
	end
	local colors = {}
	for k, _ in pairs(Colors.colors) do
		table.insert(colors, k)
	end
	M.colors = colors
	return colors
end

function M.get_flavours(color)
	if M.flavours[color] then
		return M.flavours[color]
	end
	local flavours = {}
	for k, _ in pairs(Colors.colors[color].flavours or {}) do
		table.insert(flavours, k)
	end
	M.flavours[color] = flavours
	return flavours
end

function M.pick_flavour(color)
	vim.ui.select(M.get_flavours(color), {
		prompt = "Select flavour",
	}, function(flavour)
		Colors.colors[color]:apply(flavour)
	end)
end

function M.pick_color()
	vim.ui.select(M.get_colors(), {
		prompt = "Select colors",
	}, function(color)
		if not color then
			return
		end
		if M.get_flavours(color) and #M.get_flavours(color) > 1 then
			M.pick_flavour(color)
			return
		end
		Colors.colors[color]:apply()
	end)
end

return M
