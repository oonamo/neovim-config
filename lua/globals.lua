-- source https://github.com/mcauley-penney/nvim/blob/main/lua/globals.lua
local sev = vim.diagnostic.severity

local borders = {
	none = { "", "", "", "", "", "", "", "" },
	invis = { " ", " ", " ", " ", " ", " ", " ", " " },
	thin = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	edge = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }, -- Works in Kitty, Wezterm
}

local icons = {
	branch = "",
	bullet = "•",
	o_bullet = "○",
	check = "✔",
	d_chev = "∨",
	ellipses = "…",
	file = "╼",
	hamburger = "≡",
	lock = "",
	r_chev = ">",
	ballot_x = " ",
	up_tri = " ",
	info_i = " ",
	--  ballot_x = '✘',
	--  up_tri = '▲',
	--  info_i = '¡',
}

_G.tools = {
	ui = {
		cur_border = borders.invis,
		borders = borders,
		icons = icons,
		lsp_signs = {
			[sev.ERROR] = { name = "Error", sym = icons["ballot_x"] },
			[sev.WARN] = { name = "Warn", sym = icons["up_tri"] },
			[sev.INFO] = { name = "Info", sym = icons["info_i"] },
			[sev.HINT] = { name = "Hint", sym = icons["info_i"] },
		},
	},
}
