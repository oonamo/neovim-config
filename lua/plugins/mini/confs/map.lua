local map = require("mini.map")

local opts = {
	integrations = {
		map.gen_integration.builtin_search(),
		map.gen_integration.diff(),
		map.gen_integration.diagnostic(),
	},
	symbols = {
		encode = require("mini.map").gen_encode_symbols.dot("4x2"),
		scroll_line = "█",
		scroll_view = "┃",
	},
	window = {
		focusable = false,
		side = "right",
		show_integration_count = false,
		width = 10,
		winblend = 25,
		zindex = 10,
	},
}

local s_opts = {
	integrations = {},
	symbols = {
		encode = nil,
		scroll_line = "█",
		scroll_view = "┃",
	},
	window = {
		focusable = false,
		side = "right",
		show_integration_count = false,
		width = 1,
		winblend = 25,
		zindex = 10,
	},
}

vim.b.scrollbar = 1

map.setup(s_opts)

local function toggle_view()
	if vim.b.scrollbar == 1 then
		vim.b.scrollbar = 0
		MiniMap.config = s_opts
	else
		vim.b.scrollbar = 1
		MiniMap.config = opts
	end
	MiniMap.toggle()
	vim.schedule(MiniMap.toggle)
	MiniMap.refresh()
end

local auto_open = {
	markdown = true,
	lua = true,
	rust = true,
	c = true,
}

local function should_enable()
	local ft = vim.bo.ft
	local disable = vim.b.minmap_disable
	local disable_man = vim.b.minimap_diable == false
	return disable_man or auto_open[ft] and not disable
end

local function toggle()
	vim.g.minmap_disable = not vim.g.minmap_disable
	if should_enable() then
		MiniMap.toggle()
	end
end

local function buf_toggle()
	if should_enable() then
		vim.b.minimap_diable = true
		MiniMap.close()
	else
		vim.b.minimap_diable = false
		MiniMap.open()
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if should_enable() then
			MiniMap.open()
		else
			MiniMap.close()
		end
	end,
})

-- vim.keymap.set("n", "<leader>mo", MiniMap.toggle, { desc = "open mini map" })
vim.keymap.set("n", "<leader>mv", toggle_view, { desc = "open mini map" })
-- MiniMap.open()
