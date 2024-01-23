return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	init = function()
		vim.g.codeium_render = true
		-- vim.g.codeium_no_map_tab = true
	end,
	config = function()
		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, desc = "Codeium Accept", silent = true })
	end,
}