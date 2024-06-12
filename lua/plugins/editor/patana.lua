if vim.o.background == "dark" then
	utils.hl = {
		opts = {
			{ "Constant", { fg = "#589C48" } },
			{ "Character", { link = "String" } },
			{ "Number", { link = "Constant" } },
			{ "Boolean", { link = "Constant" } },
			{ "Float", { link = "Constant" } },
			{ "String", { link = "Constant" } },
			{ "Directory", { link = "Constant" } },
			{ "Title", { link = "Constant" } },
		},
	}
	-- vim.api.nvim_set_hl(0, "String", { fg = "#7BB662" })
end

vim.cmd.colorscheme("patana")

utils:create_hl()
