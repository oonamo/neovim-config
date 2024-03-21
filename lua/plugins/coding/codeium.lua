return {
	"Exafunction/codeium.vim",
	event = { "InsertEnter" },
	ft = { "!markdown", "!norg" },
	init = function()
		vim.g.codeium_render = true
		vim.g.codeium_filetypes = {
			["markdown"] = false,
			["norg"] = false,
			["*"] = true,
		}
	end,
	config = function()
		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, desc = "Codeium Accept", silent = true })
	end,
}
