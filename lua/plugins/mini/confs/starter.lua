local starter = require("mini.starter")

-- local grapple = require("grapple")
-- gets in the way
-- local function grapple_paths()
-- 	return vim.iter(grapple.tags())
-- 		:map(function(v)
-- 			return { name = v.path, section = "Grapple", action = "e " .. v.path }
-- 		end)
-- 		:totable()
-- end

local function header()
	math.randomseed(124, 101251254)
	local maxwells_eqns = {
		[[∫E⋅dl = -d/dt∫B⋅ds, Lenz's law / Faraday's Law.]],
		[[∫E⋅dA = ρ/ϵ, Gauss's Law ]],
		[[∫B⋅dl = μ(∫J⋅ds +ϵ⋅d/dt∫E⋅ds), addition to Ampere's Law.]],
	}

	local sep = "=================================="

	local rand = math.random(3)
	return vim.iter({ sep, maxwells_eqns[rand] }):join("\n")
end

starter.setup({
	evaluate_single = true,
	header = header(),
	items = {
		starter.sections.sessions(5, true),
		-- grapple_paths(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.indexing("all", { "Sessions" }),
		starter.gen_hook.aligning("center", "center"),
		-- starter.gen_hook.padding(5, 2),
		-- starter.gen_hook.aligning("left", "top"),
	},
	footer = "==================================",
})
