require("mini.extra").setup()
require("mini.bufremove").setup()

if O.ui.indent.mini then
	require("mini.indentscope").setup({
		-- draw = {
		-- 	animation = require("mini.indentscope").gen_animation.none(),
		-- },
		symbol = "│",
		options = { try_as_border = true },
	})
	if utils.get_hl("NonText") then
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
	else
		local fg, _, _ = utils.get_hl("Normal")
		if fg == nil then
			fg = "#ffffff"
		end
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = fg })
	end
end

if O.ui.clues then
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},

		clues = {
			Config.leader_group_clues,
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
		window = { config = { border = "double" } },
	})
end

if O.ui.tree.mini then
	require("mini.files").setup({
		windows = { preview = true },
	})
	vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "open mini files" })
	vim.keymap.set("n", "<leader>fl", function()
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
		MiniFiles.reveal_cwd()
	end, { desc = "open mini files" })
end

require("mini.splitjoin").setup()
require("mini.surround").setup({

	mappings = {
		add = "gsa", -- Add surrounding in Normal and Visual modes
		delete = "gsd", -- Delete surrounding
		find = "gsf", -- Find surrounding (to the right)
		find_left = "gsF", -- Find surrounding (to the left)
		highlight = "gsh", -- Highlight surrounding
		replace = "gsr", -- Replace surrounding
		update_n_lines = "gsn", -- Update `n_lines`

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
})
-- require("mini.comment").setup()
require("mini.ai").setup({
	custom_textobjects = {
		B = MiniExtra.gen_ai_spec.buffer(),
	},
})

local hipatterns = require("mini.hipatterns")
local hi_words = MiniExtra.gen_highlighter.words
hipatterns.setup({
	highlighters = {
		fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
		hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
		todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
		note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
-- No need to copy this inside `setup()`. Will be used automatically.
require("mini.notify").setup({
	-- Window options
	window = {
		config = { border = "double" },
	},
})
vim.notify = require("mini.notify").make_notify()

vim.api.nvim_create_user_command("Notifications", function()
	local win_id = vim.api.nvim_open_win(0, true, {
		split = "below",
		vertical = false,
		anchor = "SE",
		win = -1,
		-- buffer = 0,
	})
	MiniNotify.show_history()
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win_id, false)
	end, { buffer = 0 })
end, {})

require("mini.diff").setup({
	view = {
		-- Visualization style. Possible values are 'sign' and 'number'.
		-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
		-- style = vim.go.number and "number" or "sign",
		style = "sign",
		-- Signs used for hunks with 'sign' view
		signs = { add = "▒", change = "▒", delete = "▒" },
		-- Priority of used visualization extmarks
		priority = 199,
	},
})
