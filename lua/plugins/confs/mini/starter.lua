local starter = require("mini.starter")

local function header()
	math.randomseed(124)
	local maxwells_eqns = {
		[[∫E⋅dl = -d/dt∫B⋅ds, Lenz's law / Faraday's Law.]],
		[[∫E⋅dA = ρ/ϵ, Gauss's Law ]],
		[[∫B⋅dl = μ(∫J⋅ds +ϵ⋅d/dt∫E⋅ds), addition to Ampere's Law.]],
	}

	local sep = "=================================="

	local rand = math.random(3)

	-- HACK: Use ipairs to skip iterator check
	-- return vim.iter({ sep, maxwells_eqns[rand] }):join("\n")
	return sep .. "\n" .. maxwells_eqns[rand]
end

starter.setup({
	evaluate_single = true,
	header = header(),
	items = {
		starter.sections.builtin_actions(),
		(function()
			local items = starter.sections.telescope()()
			table.remove(items, 1)
			return items
		end)(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.indexing("all", { "Builtin actions" }),
		starter.gen_hook.aligning("center", "center"),
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniStarterOpened",
	callback = function()
		vim.schedule(function()
			vim.opt_local.rnu = false
			vim.opt_local.number = false
		end)
		vim.b.miniindentscope_disable = true
	end,
})
