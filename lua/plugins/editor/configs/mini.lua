require("mini.extra").setup()
require("mini.bufremove").setup()

if O.ui.indent.mini then
	require("mini.indentscope").setup({
		symbol = "│",
		options = {
			try_as_border = true,
			border = "both",
			indent_at_cursor = true,
		},
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
	local function map_split(buf_id, lhs, direction)
		local minifiles = require("mini.files")

		local function rhs()
			local window = minifiles.get_target_window()

			-- Noop if the explorer isn't open or the cursor is on a directory.
			if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
				return
			end

			-- Make a new window and set it as target.
			local new_target_window
			vim.api.nvim_win_call(window, function()
				vim.cmd(direction .. " split")
				new_target_window = vim.api.nvim_get_current_win()
			end)

			minifiles.set_target_window(new_target_window)

			-- Go in and close the explorer.
			minifiles.go_in({ close_on_file = true })
		end

		vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
	end

	require("mini.files").setup({
		mappings = {
			show_help = "?",
			go_in_plus = "<cr>",
			go_out_plus = "<tab>",
		},
		content = {
			filter = function(entry)
				return entry.fs_type ~= "file" or entry.name ~= ".DS_Store"
			end,
			sort = function(entries)
				local function compare_alphanumerically(e1, e2)
					-- Put directories first.
					if e1.is_dir and not e2.is_dir then
						return true
					end
					if not e1.is_dir and e2.is_dir then
						return false
					end
					-- Order numerically based on digits if the text before them is equal.
					if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
						return e1.digits < e2.digits
					end
					-- Otherwise order alphabetically ignoring case.
					return e1.lower_name < e2.lower_name
				end

				local sorted = vim.tbl_map(function(entry)
					local pre_digits, digits = entry.name:match("^(%D*)(%d+)")
					if digits ~= nil then
						digits = tonumber(digits)
					end

					return {
						fs_type = entry.fs_type,
						name = entry.name,
						path = entry.path,
						lower_name = entry.name:lower(),
						is_dir = entry.fs_type == "directory",
						pre_digits = pre_digits,
						digits = digits,
					}
				end, entries)
				table.sort(sorted, compare_alphanumerically)
				-- Keep only the necessary fields.
				return vim.tbl_map(function(x)
					return { name = x.name, fs_type = x.fs_type, path = x.path }
				end, sorted)
			end,
		},
		windows = { width_nofocus = 25 },
		-- Move stuff to the minifiles trash instead of it being gone forever.
		options = { permanent_delete = false },
	})
	vim.api.nvim_create_autocmd("User", {
		desc = "Add rounded corners to minifiles window",
		pattern = "MiniFilesWindowOpen",
		callback = function(args)
			vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		desc = "Add minifiles split keymaps",
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			map_split(buf_id, "<C-s>", "belowright horizontal")
			map_split(buf_id, "<C-v>", "belowright vertical")
		end,
	})
	vim.keymap.set("n", "<leader>e", function()
		local bufname = vim.api.nvim_buf_get_name(0)
		local path = vim.fn.fnamemodify(bufname, ":p")

		-- Noop if the buffer isn't valid.
		if path and vim.uv.fs_stat(path) then
			require("mini.files").open(bufname, false)
		end
	end, { desc = "File explorer" })
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
	})
	MiniNotify.show_history()
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win_id, false)
	end, { buffer = 0 })
end, {})

require("mini.diff").setup()

vim.keymap.set("n", "<leader>gdo", MiniDiff.toggle_overlay, { desc = "MiniDiff toggle overlay" })
vim.keymap.set("n", "<leader>gdf", MiniDiff.toggle_overlay, { desc = "MiniDiff show overlay" })

require("mini.move").setup({
	mappings = {
		left = "H",
		right = "L",
		line_left = "H",
		down = "J",
		up = "K",
	},
})

require("mini.git").setup({
	command = {
		split = "vertical",
	},
})

vim.keymap.set("n", "<leader>gs", "<CMD>Git status<CR>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gac", "<CMD>Git add %<CR>", { desc = "Git Add Current" })
vim.keymap.set("n", "<leader>gaa", "<CMD>Git add .<CR>", { desc = "Git Add All" })
vim.keymap.set("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git Push" })
vim.keymap.set("n", "<leader>gc", function()
	vim.ui.input({ prompt = "Commit: " }, function(input)
		if not input then
			return
		end
		local formatted_str = vim.iter(vim.gsplit(input, " ")):join("\\ ")
		local str = string.format("Git commit -m %s", formatted_str)
		vim.cmd(str)
	end)
end, { desc = "Git Commit" })
