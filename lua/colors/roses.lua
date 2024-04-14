local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if flavour == "dawn" then
		vim.o.background = "light"
	elseif flavour == "prime" then
		require("colors.prime-pine").setup()
		require("colors.prime-pine").setup_pmenu()
		return
	else
		vim.o.background = "dark"
	end
	require("rose-pine").setup({
		variant = flavour,
		style = {
			bold = true,
			italic = true,
		},
		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",

			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",

			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",

			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
	})
	vim.cmd("colorscheme rose-pine-" .. flavour)
end

return M
