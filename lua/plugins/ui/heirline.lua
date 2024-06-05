local heirline_utils = require("heirline.utils")
local heirline = require("heirline")
local function get_colors()
	local onam_utils = require("onam.utils")
	local fg, bg, _ = onam_utils.get_hl("StatusLine")
	local bright_fg, bright_bg, _ = onam_utils.get_hl("Folded")
	if not bright_bg then
		_, bright_bg, _ = onam_utils.get_hl("CursorLine")
	end
	if not bright_fg then
		bright_fg, _, _ = onam_utils.get_hl("CursorLine")
	end
	if not bg then
		bg = "NONE"
	end
	local colors = {
		bright_bg = bright_bg,
		bright_fg = bright_fg,
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
		text = heirline_utils.get_highlight("Normal").bg,
		winbar_fg = heirline_utils.get_highlight("WinBar").fg or "NONE",
		winbar_bg = heirline_utils.get_highlight("WinBar").bg or "NONE",
		fg = fg,
		bg = bg,
	}
	if not vim.g.use_noice then
		vim.o.cmdheight = 1
		vim.g.noshowmode = true
	end
	return colors
end

local statusline = { statusline = require("plugins.ui.heirline.tjline") }
local conditions = require("heirline.conditions")
heirline.setup({
	statusline = statusline.statusline,
	opts = {
		colors = get_colors(),
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = { "nofile", "prompt", "help", "quickfix" },
				filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
			}, args.buf)
		end,
	},
})
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		heirline_utils.on_colorscheme(get_colors)
	end,
	group = "Heirline",
})
