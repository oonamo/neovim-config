return {
	"b0o/incline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	events = "VeryLazy",
	cond = O.ui.incline == true,
	opts = {
		window = {
			padding = 0,
			margin = {
				horizontal = 2,
				vertical = 2,
			},
			placement = {
				horizontal = "center",
				vertical = "bottom",
			},
		},
		render = function(props)
			local _, float_bg, _ = utils.get_hl("NormalFloat")
			local _, norm_bg, _ = utils.get_hl("Normal")

			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end
			local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

			return {
				{ "", guibg = norm_bg, guifg = float_bg },
				ft_icon and { ft_icon .. " ", guifg = ft_color } or {},
				filename,
				{ "", guibg = norm_bg, guifg = float_bg },
			}
		end,
	},
}
