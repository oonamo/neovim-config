-- TODO:
-- make heirline work with gruvbox light themes
return {
	"rebelot/heirline.nvim",
	-- dependencies = { "Zeioth/heirline-components.nvim" },
	cond = function()
		if not vim.g.heirline_enabled then
			return false
		end
		return true
	end,
	lazy = true,
	event = { "VeryLazy" },
	config = function(_, opts)
		local heirline_utils = require("heirline.utils")
		local heirline = require("heirline")
		local function get_colors()
			local colors = {
				bright_bg = heirline_utils.get_highlight("Folded").bg,
				bright_fg = heirline_utils.get_highlight("Folded").fg,
				red = heirline_utils.get_highlight("DiagnosticError").fg,
				dark_red = heirline_utils.get_highlight("DiffDelete").bg,
				green = heirline_utils.get_highlight("String").fg,
				blue = heirline_utils.get_highlight("Function").fg,
				gray = heirline_utils.get_highlight("NonText").fg,
				orange = heirline_utils.get_highlight("Constant").fg,
				purple = heirline_utils.get_highlight("Statement").fg,
				cyan = heirline_utils.get_highlight("Special").fg,
				diag_warn = heirline_utils.get_highlight("DiagnosticWarn").fg,
				diag_error = heirline_utils.get_highlight("DiagnosticError").fg,
				diag_hint = heirline_utils.get_highlight("DiagnosticHint").fg,
				diag_info = heirline_utils.get_highlight("DiagnosticInfo").fg,
				git_del = heirline_utils.get_highlight("diffDeleted").fg,
				git_add = heirline_utils.get_highlight("diffAdded").fg,
				git_change = heirline_utils.get_highlight("diffChanged").fg,
				fg = heirline_utils.get_highlight("StatusLine").fg,
				bg = heirline_utils.get_highlight("StatusLine").bg,
			}
			if vim.g.colors_name == "gruvbox" then
				vim.notify("gruvbox theme not supported", vim.log.levels.WARN)
				-- local tmp = colors.fg
				-- colors.fg = colors.bg
				colors.bg = "#000000"
				-- tmp = colors.bright_fg
				colors.bright_fg = "#000000"
				colors.bright_bg = "#000000"
			end
			return colors
		end
		local statusline = require("plugins.ui.heirline.statusline")
		local tabline = require("plugins.ui.heirline.tabline")
		heirline.setup({
			statusline = statusline.statusline,
			tabline = tabline,
			winbar = statusline.winbar,
			opts = {
				colors = get_colors(),
			},
		})
		vim.o.showtabline = 2
		vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
		vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd({ "ColorScheme" }, {
			callback = function()
				heirline_utils.on_colorscheme(get_colors)
			end,
			group = "Heirline",
		})
	end,
}
