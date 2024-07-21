local animate = require("mini.animate")
animate.setup({
	scroll = {
		enable = false,
	},
	cursor = {
		timing = animate.gen_timing.cubic({ duration = 50, unit = "total" }),
		path = animate.gen_path.line({
			predicate = function()
				return true
			end,
		}),
	},
	open = {
		enable = true,
		timing = animate.gen_timing.linear({
			duration = 1000,
			unit = "total",
		}),
		-- winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
		-- winconfig = animate.gen_winconfig.center({}),
		winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
	},
	close = {
		enable = true,
		timing = animate.gen_timing.linear({
			duration = 1000,
			unit = "total",
		}),
		-- winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
		-- winconfig = animate.gen_winconfig.center({}),
		winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
	},
})
