return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local obsidian = "C:/Users/onam7/Desktop/DB/DB/"
		-- dashboard.section.header.val = {
		-- 	[[ ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ]],
		-- 	[[•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪]],
		-- 	[[▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·]],
		-- 	[[██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌]],
		-- 	[[▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀]],
		-- }
		dashboard.section.header.val = {}
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", ":FzfLua files<CR>"),
			dashboard.button("s", " " .. " Manage My Sessions", "<cmd>ManageMySessions<CR>"),
			dashboard.button("o", " " .. " Open Obsidian", ":cd " .. obsidian .. " | e base.md<CR>"),
			dashboard.button("q", " " .. " Quit", ":qa<CR>"),
		}

		local function get_lazy_stats()
			local stats = require("lazy").stats()
			return "⚡ Neovim loaded "
				.. stats.loaded
				.. " / "
				.. stats.count
				.. " plugins in "
				.. (stats.times.LazyDone + stats.times.LazyStart)
				.. "ms"
		end

		dashboard.section.footer.val = get_lazy_stats()
		dashboard.section.footer.opts.hl = "Constant"

		alpha.setup(dashboard.config)
		-- alpha.setup(theta.config)
	end,
}
