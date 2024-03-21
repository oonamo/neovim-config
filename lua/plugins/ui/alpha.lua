return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		-- require("alpha").setup(require("alpha.themes.startify").config)
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local obsidian = "C:/Users/onam7/Desktop/DB/DB/"

		dashboard.section.header.val = {
			[[ ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ]],
			[[•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪]],
			[[▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·]],
			[[██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌]],
			[[▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", ":FzfLua files<CR>"),
			dashboard.button("s", " " .. " Manage My Sessions", "<cmd>ManageMySessions<CR>"),
			dashboard.button("o", " " .. " Open Obsidian", ":cd " .. obsidian .. " | e base.md<CR>"),
			dashboard.button("q", " " .. " Quit", ":qa<CR>"),
		}

		local function get_lazy_stats()
			local stats = require("lazy").stats()
			-- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			local ms = string.format("%.2f", stats.startuptime)
			return "⚡ Neovim loaded " .. stats.loaded .. " / " .. stats.count .. " plugins in " .. ms .. "ms"
		end

		dashboard.section.footer.val = get_lazy_stats()
		-- dashboard.section.footer.opts.hl = "Constant"

		alpha.setup(dashboard.config)
	end,
}
