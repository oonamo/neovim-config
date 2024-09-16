local miniclue = require("mini.clue")

local function mark_clues()
	local marks = {}
	vim.list_extend(marks, vim.fn.getmarklist(vim.api.nvim_get_current_buf()))
	vim.list_extend(marks, vim.fn.getmarklist())

	return vim.iter(marks)
		:map(function(mark)
			local key = vim.trim(mark.mark:sub(2, 2))

			-- Just look at letter marks.
			if not string.match(key, "^%a") then
				return nil
			end

			-- For global marks, use the file as a description.
			-- For local marks, use the line number and content.
			local desc
			if mark.file then
				desc = vim.fn.fnamemodify(mark.file, ":p:~:.")
			elseif mark.pos[1] and mark.pos[1] ~= 0 then
				local line_num = mark.pos[2]
				local lines = vim.fn.getbufline(mark.pos[1], line_num)
				if lines and lines[1] then
					desc = string.format("%d: %s", line_num, lines[1]:gsub("^%s*", ""))
				end
			end

			if desc then
				return { mode = "n", keys = string.format("`%s", key), desc = desc }
			end
		end)
		:totable()
end

-- Clues for recorded macros.
local function macro_clues()
	local res = {}
	for _, register in ipairs(vim.split("abcdefghijklmnopqrstuvwxyz", "")) do
		local keys = string.format('"%s', register)
		local ok, desc = pcall(vim.fn.getreg, register, 1)
		if ok and desc ~= "" then
			table.insert(res, { mode = "n", keys = keys, desc = desc })
			table.insert(res, { mode = "v", keys = keys, desc = desc })
		end
	end

	return res
end

miniclue.setup({
	triggers = {
		-- Leader triggers
		-- { mode = "n", kyes = "]" },
		-- { mode = "n", kyes = "[" },
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		{ mode = "n", keys = "<localleader>" },
		{ mode = "x", keys = "<localleader>" },

		{ mode = "n", keys = "[" },
		{ mode = "x", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = "x", keys = "]" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "n", keys = '"' },
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

	clues = { -- {{{
		Config.leader_group_clues,
		Config.submodes,
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows({
			submode_move = true,
			submode_navigate = false,
			submode_resize = true,
		}),
		miniclue.gen_clues.z(),
		mark_clues,
		macro_clues,
	}, -- }}}
	-- window = { config = { border = "double" } },
	-- window = { config = { border = tools.ui.borders.edge } },
	window = {
		delay = 500,
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
		config = function(bufnr)
			local max_width = 0
			for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
				max_width = math.max(max_width, vim.fn.strchars(line))
			end

			-- Keep some right padding.
			max_width = max_width + 2

			return {
				border = "rounded",
				-- Dynamic width capped at 45.
				width = math.min(45, max_width),
			}
		end,
	},
})
