local miniai = require("mini.ai")
miniai.setup({
	custom_textobjects = {
		B = MiniExtra.gen_ai_spec.buffer(),
		-- F = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
	},
	search_method = "cover_or_next",
})

local function something()
	print("something")
end

something()
