local M = {}

function M.setup()
	vim.cmd.hi("clear")
	vim.o.background = "light"
	vim.cmd.colorscheme("deepwhite")
	utils.hl = {
		opts = {
			-- { "DiffChange", { link = "String" } },
			-- { "DkffAdd", { link = "Constant" } },
			-- { "DiffDelete", { link = "Statement" } },
			{ "DiffAdd", { bg = "#d0d6cd" } },
			{ "DiffChange", { bg = "#cde0dd" } },
			{ "DiffDelete", { bg = "#e6c8c8" } },
			{ "markdownH1", { fg = "#000000" } },
			{ "markdownH2", { fg = "#000000" } },
			{ "markdownH3", { fg = "#000000" } },
			{ "markdownH4", { fg = "#000000" } },
			{ "markdownH5", { fg = "#000000" } },
			{ "markdownH6", { fg = "#000000" } },
			{ "@markup.heading.1.markdown", { link = "markdownH1" } },
			{ "@markup.heading.2.markdown", { link = "markdownH2" } },
			{ "@markup.heading.3.markdown", { link = "markdownH3" } },
			{ "@markup.heading.4.markdown", { link = "markdownH4" } },
			{ "@markup.heading.5.markdown", { link = "markdownH5" } },
			{ "@markup.heading.6.markdown", { link = "markdownH6" } },
		},
	}
end

return M
