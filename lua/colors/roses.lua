local M = {}
M.fn = "prime-pine"
M.name = "rose-pine"

M.colors = {
	fg = "#e0def4",
	-- bg = "#28272a",
	-- bg = "#1c1c1c",
	green = "#698282",
	yellow = "#ffc2c6",
	magenta = "#dda0dd",
	red = "#ea83a5",
	blue = "#31748f",
	cyan = "#b3c3c4",
	gray = "#3d3d3d",
	orange = "#d3a38d",
	white = "#e0def4",
	black = "#21202e",
}

function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if flavour == "dawn" then
		vim.o.background = "light"
		-- utils.hl = {
		-- 	opts = {
		-- 		{ "@property", { fg = "#b4637a" } }, -- love
		-- 		{ "@variable", { fg = "#575279" } }, -- text
		-- 		-- { "@keyword", { fg = "#ea9d34" } }, -- gold
		-- 		-- { "@lsp.type.parameter", { fg = "#286983" } }, -- foam
		-- 		{ "@function", { fg = "#907aa9" } }, -- iris
		-- 		{ "@function.builtin", { fg = "#907aa9" } },
		-- 	},
		-- }
	elseif flavour == "prime" then
		require("colors.prime-pine").setup()
		require("colors.prime-pine").setup_pmenu()
		return
	else
		vim.o.background = "dark"
	end
	require("rose-pine").setup({
		variant = flavour,
		styles = {
			bold = true,
			italic = true,
			transparency = false,
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
		highlight_groups = {
			-- StatusLine = { bg = "foam", fg = "foam", blend = 10 },
			StatusLine = { bg = "foam", fg = "text", blend = 5 },
			-- StatusLineNC = { bg = "foam", fg = "text" },
		},
	})
	vim.cmd("colorscheme rose-pine-" .. flavour)
	if flavour == "dawn" then
		utils:create_hl()
	end
end

return M
