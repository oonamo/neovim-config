local grapple = require("grapple")
local starter = require("mini.starter")

local function grapple_paths()
	return vim.iter(grapple.tags())
		:map(function(v)
			return { name = v.path, section = "Grapple", action = "e " .. v.path }
		end)
		:totable()
end

-- vim.print(grapple_paths())

starter.setup({
	evaluate_single = true,
	items = {
		starter.sections.sessions(5, true),
		grapple_paths(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		-- starter.gen_hook.indexing("all", { "Builtin actions" }),
		starter.gen_hook.padding(5, 2),
		starter.gen_hook.aligning("left", "top"),
	},
})
