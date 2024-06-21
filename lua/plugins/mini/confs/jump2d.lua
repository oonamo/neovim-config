local jump2d = require("mini.jump2d")

jump2d.setup({
	view = {
		dim = true,
	},
	mappings = {
		start_jumping = "",
	},
})

vim.keymap.set("i", "<C-o>", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d" })

local function jump_word()
	local opts = { hooks = {} }
	local noop = function()
		return {}
	end
	opts.spotter = noop

	local function gen_word_start(char_pattern, char)
		local jump = require("mini.jump2d")

		local camel_pattern = string.format("[%%l]+%s", char)
		local camel_spotter = jump.gen_pattern_spotter(camel_pattern, "end")

		local word_spotter = jump.builtin_opts.word_start.spotter
		local char_spotter = jump.gen_pattern_spotter(char_pattern)

		local word_start = function(num, args)
			local cs = char_spotter(num, args)
			if cs == nil then
				vim.notify("nil")
				return {}
			end

			local ws = word_spotter(num, args)
			local res = {}

			for _, i in ipairs(cs) do
				if vim.tbl_contains(ws, i) then
					res[#res + 1] = i
				end
			end

			return res
		end

		return jump.gen_union_spotter(word_start, camel_spotter)
	end

	opts.hooks.before_start = function()
		local ok, ch = pcall(vim.fn.getcharstr)
		if ok == false or ch == nil then
			opts.spotter = noop
			return
		end

		if ch:match("[a-z]") then
			local upper = ch:upper()
			local pattern = string.format("[%s%s]", ch, upper)

			opts.spotter = gen_word_start(pattern, upper)
			return
		end

		if ch:match("[A-Z]") then
			opts.spotter = gen_word_start(ch, ch)
			return
		end

		local pattern = string.format("[%s]", vim.pesc(ch))
		opts.spotter = require("mini.jump2d").gen_pattern_spotter(pattern)
	end

	return function()
		require("mini.jump2d").start(opts)
	end
end

vim.keymap.set("n", "<leader>r", jump_word(), { desc = "jump to word" })
