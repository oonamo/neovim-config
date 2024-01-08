return {
	"Exafunction/codeium.vim",
	event = { "BufReadPre", "BufNewFile" },
	init = function()
		vim.g.codeium_render = true
		-- vim.g.codeium_no_map_tab = true
	end,
	config = function()
		vim.keymap.set("i", "<C-i>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, desc = "Codeium Accept" })
	end,
}
