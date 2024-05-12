return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
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
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
		end

		if O.ui.tree.mini then
			require("mini.files").setup({})
			vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "open mini files" })
		end

		require("mini.splitjoin").setup()
		require("mini.surround").setup({
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				leplace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})
	end,
}
